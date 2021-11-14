import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //Collection reference de usuarios
  final CollectionReference agroCollection =
      FirebaseFirestore.instance.collection('users');

  //Collection reference de mensajes de usuarios
  final CollectionReference agroMessagesCollection =
  FirebaseFirestore.instance.collection('questions');




  //ESTO NO SE ESTA USANDO PARA EL LOGIN!!! ASI SE METE INFO EN FIREBASE
  Future updateUserData(
      String name, String email, String picture) async {
    return await agroCollection.doc(uid).set({
      'name': name,
      "email": email,
      "picture": picture,
    });
  }

  Future saveQuestion(
      String pregunta, String detalles, String tema, String image) async {
    return await agroCollection.doc(uid).set({
      'question': pregunta,
      "details": detalles,
      "theme": tema,
      "picture": image,
    });
  }


  /* **********************************
  Métodos para manejar imágenes  en Firestorage
   * **********************************/

  //variables para subir imagenes
  UploadTask? imageTask;    //para monitorear la tarea de subir imagen
  FirebaseStorage fireStorage = FirebaseStorage.instance; //instancia de firestorage para hacer peticiones

  // método para subir imagenes a firestore
  Future uploadFile (String destination, File file)async{

    try{

      Reference ref = fireStorage.ref(destination);
      imageTask = ref.putFile(file);

      agroCollection.doc(uid).update({"picture" : destination});

      return imageTask;

    }on FirebaseException catch (e){

      log("Hubo un error al subir la imagen a firebase: " + e.toString());
      return null;
    }

  }

  // Metodo para cargar la imagen de perfil al inciar sesión
  Future loadProfileImageOnStartup() async{

    final DocumentSnapshot<Object?> response = await agroCollection.doc(uid).get();
    Reference ref = fireStorage.ref().child(response.get("picture"));
    String url = await ref.getDownloadURL();

    return url;
 }


 // Método para cargar imagen de algún mensaje
  Future<String> getImageFromMessage(String messageId) async{

    final DocumentSnapshot<Object?> response = await agroMessagesCollection.doc(messageId).get();
    String picName = response.get("picture");

    if (  picName == '' ){
      //si no hay imagen retorna un string en blanco
      return '';
    }

    Reference ref = fireStorage.ref().child(picName);
    String url = await ref.getDownloadURL();

    // si hay url de la imagen la manda
    return url;

  }



}
