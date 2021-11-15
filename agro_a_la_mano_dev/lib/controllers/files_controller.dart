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
  FilePickerResult? _resultFromProfile;       //guarda resultado de buscar una imagen en la pagina de perfil
  FilePickerResult? _resultFromMessage;       //guarda resultado de buscar una imagen en la pagina de mensaje

  File? _profileImageFile;                     //guarda las imagenes que se cargan para subir a firestore
  File? _messageImageFile;                     //guarda las imagenes que se cargan para subir a firestore

  TaskSnapshot? _taskSnapshot;

  var profileImageUrl = ''.obs;    //guarda la url de la imagen de perfil de un usuario
  var messageImageUrl = ''.obs;    //guarda la url de la imagen del mensaje de un usuario

  late DatabaseService firebaseConn; //conexión con la base de datos de firebase


  get profileImagePath => _resultFromProfile.isNull? '' : 'images/' + _resultFromProfile!.files.single.name;
  get messageImagePath => _resultFromMessage.isNull? '' : 'images/' + _resultFromMessage!.files.single.name;

  FileController(){
    firebaseConn =  DatabaseService(uid: _authcontroller.uid); //conexión con la api para enviar archivos a firestore
    loadProfileImageOnStartup();
  }


  /* **************************************************
      Funciones de buscado de imagenes para subir
  * ***************************************************/


  Future browseFilesForProfileImage() async{
    FilePickerResult? result  =  await browseFiles();

    // si no se selecciona ninguna imagen entonces no se actualizan las variables
    // y se conservan las anteriores
    if (result != null){
      _resultFromProfile = result;
      _profileImageFile = File(_resultFromProfile!.files.single.path!);

      return true;

    }else{

      return false;
    }

  }

  Future browseFilesForMessageImage() async{
    FilePickerResult? result  =  await browseFiles();

    // si no se selecciona ninguna imagen entonces no se actualizan las variables
    // y se conservan las anteriores

    try{
      _resultFromMessage = result;
      if(_resultFromMessage == null) return false;

      _messageImageFile = File(_resultFromMessage!.files.single.path!);
      return true;

    }catch(e){

      log("Al buscar imagen de mensaje ocurrió: " + e.toString());
      log("ruta a la imagen seleccionada: " + this.messageImagePath);
      return false;
    }

  }


  Future browseFiles() async{
    FilePickerResult? localResult = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
    );

    return localResult;
  }


  /* ****************************************************************
        Funciones para subir imagenes
   * ****************************************************************/


  // Función para subir imagen dado el archivo a subir y el resultado de haberlo
  // buscado con el buscador

  Future uploadFile(File? file, FilePickerResult? result, String messageId)async {
    if (file == null) return false;

    final fileName = result!.files.single.name;
    final destination = 'images/$fileName';

    //en caso de que el messageId sea '' se asume que se quiere subir una foto de perfil
     _taskSnapshot = await firebaseConn.uploadFile(destination, file, messageId);

    if(_taskSnapshot != null){
      return true;
    }else{
      return false;
    }

  }

  // Función para actualizar un achivo previo con otro nuevo
  // en concreto reemplazar una foto de perfil por otra nueva

  Future updatePreviousProfilePic(File? file, FilePickerResult? result) async{

    if (file == null) return false;

    final fileName = result!.files.single.name;
    final destination = 'images/$fileName';

    _taskSnapshot = await firebaseConn.updatePreviousProfilePic(destination, file);

    if(_taskSnapshot != null){
      return true;
    }else{
      return false;
    }

  }


  //Actualiza la foto de perfil y actualiza la URL de la foto de perfil
  Future uploadProfilePic() async {

    try {
      bool resultFromSearch = await this.browseFilesForProfileImage();

      // si no seleccionó nada en el menú de búsqueda retorne falso y pare
      // la ejecución
      if (!resultFromSearch) return false;

      await this.updatePreviousProfilePic(_profileImageFile!, _resultFromProfile);

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


  Future uploadMessagePic(String messageId) async{


    try {
      //await this.browseFilesForMessageImage();
      await this.uploadFile(_messageImageFile!, _resultFromMessage, messageId);

      messageImageUrl.value = await _taskSnapshot!.ref.getDownloadURL();
      refresh();
      return true;

    }catch (e){

      log("Hubo un error al subir/cargar imagen de mensaje: " + e.toString());
      messageImageUrl.value = '';
      refresh();
      return false;
    }
  }



  Future loadProfileImageOnStartup() async{
    profileImageUrl.value = await firebaseConn.loadProfileImageOnStartup();

    refresh();
    return true;
  }


  Future loadMessageImageOnRequest(String messageId)async{
    messageImageUrl.value =  await getMessageUrl(messageId);

    log("La url del mensaje solicitado es: " + messageImageUrl.value);
    refresh();
    return true;
  }



  Future<String> getMessageUrl(String messageId) async{
    return firebaseConn.getImageFromMessage(messageId);
  }




}