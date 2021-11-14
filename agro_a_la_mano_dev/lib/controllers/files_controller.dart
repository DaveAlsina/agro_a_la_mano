import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:agro_a_la_mano_dev/services/database.dart';
import 'authentication_controller.dart';




class FileController extends GetxController{
  // se inicializa tan pronto se ha podido logear un usuario
  // o tan pronto se ha registrado un usuario

  AuthenticationController _authcontroller = Get.find();
  FilePickerResult? _result;       //guarda resultado de buscar una imagen
  File? _file;                     //guarda las imagenes que se cargan para subir a firestore
  TaskSnapshot? _taskSnapshot;
  var profileImageUrl = ''.obs;    //guarda la url de la imagen de perfil de un usuario

  late DatabaseService firebaseConn; //conexión con la base de datos de firebase

  FileController(){
    firebaseConn =  DatabaseService(uid: _authcontroller.uid); //conexión con la api para enviar archivos a firestore
    loadProfileImageOnStartup();
  }



   // abre un buscador para seleccionar la imagen
   // a subir
  Future browseFiles() async{
    _result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
    );

    if (_result != null){
       _file = File(_result!.files.single.path!);

      return true;
    }else{

      return false;
    }

  }

  // sube la imagen a firebase storage
  Future uploadFile()async {
    if (_file == null) return false;

    final fileName = _result!.files.single.name;
    final destination = 'images/$fileName';

     _taskSnapshot = await firebaseConn.uploadFile(destination, _file!);

    if(_taskSnapshot != null){
      return true;
    }else{
      return false;
    }

  }

  Future uploadAndDeletePreviousFile() async{

    if (_file == null) return false;

    final fileName = _result!.files.single.name;
    final destination = 'images/$fileName';

    _taskSnapshot = await firebaseConn.uploadAndDeletePreviousFile(destination, _file!);

    if(_taskSnapshot != null){
      return true;
    }else{
      return false;
    }

  }




  //Actualiza la foto de perfil y actualiza la URL de la foto de perfil
  Future uploadProfilePic() async {

    try {
      await this.browseFiles();
      await this.uploadAndDeletePreviousFile();

      profileImageUrl.value = await _taskSnapshot!.ref.getDownloadURL();
      refresh();
      return true;

    }catch (e){

      log("Hubo un error al subir/cargar imagen de perfil: " + e.toString());
      profileImageUrl.value = '';
      refresh();
      return false;
    }

  }

  Future loadProfileImageOnStartup() async{
    profileImageUrl.value = await firebaseConn.loadProfileImageOnStartup();

    refresh();
    return true;
  }






}