import 'dart:developer';
import 'dart:io';

import 'package:agro_a_la_mano_dev/data/repositories/models/question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //Collection reference
  final CollectionReference users =
  FirebaseFirestore.instance.collection('users');

  final CollectionReference questions =
  FirebaseFirestore.instance.collection('questions');


  //============================PREGUNTAS Y RESPUESTAS==========================

   Future saveQuestionFirebase(
      String pregunta, String detalles, String tema, String image) async {

      final ref = await questions.add(
         {
           'usuarioEnvia': uid,
           'question': pregunta,
           "details": detalles,
           "theme": tema,
           "picture": image,
           'answer': {},
         }
     );

      log("el id del mensaje guardado es: " + ref.id.toString());

      return ref.id.toString();

  }

  Future saveAnswerFirebase(String idRef, String mensaje) async {
     try{
       final DocumentSnapshot<Object?> response = await questions.doc(idRef).get();
       var ans = response.get("answer");

       if(ans is Map<String, dynamic>){
         await questions.doc(idRef).update({
           'answer':
           [{
             'usuarioResponde': uid,
             'respuesta': mensaje,
           }],
         });

       }else{
          log(ans.toString());

          ans.add(
            {
              'usuarioResponde': uid,
              'respuesta': mensaje,
            }
          );

          await questions.doc(idRef).update({
            'answer': ans
          });


       }

       return true;
     }catch(e){
       log("Error al tratar de guardar la respuesta: " + e.toString());
       return false;
     }
  }


  Future deleteDocumentFirebase(String idRef) async {
    return await questions.doc(idRef).delete();
  }


  Future<List<dynamic>> getCommentsFromMessage(String messageId)async{

     final DocumentSnapshot<Object?> response = await questions.doc(messageId).get();
     List<dynamic> ans = response.get("answer");

     return ans;
  }


  Future<List> getDataQuestions() async {
    Query query = questions.where('usuarioEnvia', isEqualTo: uid);
    QuerySnapshot querySnapshot = await query.get().whenComplete(() => null).catchError((e) =>
        log("Error al pedir los mensajes particulares del usuario: " + e.toString()));

    final allData = querySnapshot.docs;

    List finalList = [];
    for (var data in allData) {
      finalList.add(QuestionModel(
          id: data.id,
          question: data['question']!,
          details: data['details']!,
          theme: data['theme']!,
          picture: data['picture']!,
          answer: data['answer']!,
          usuarioEnvia: uid));
    }
    return finalList;
  }



  Future<List> getFeedQuestions() async {
    Query query = questions.where('usuarioEnvia', isNotEqualTo: uid);


    QuerySnapshot querySnapshot = await query
        .get()
        .whenComplete(() => null)
    // ignore: invalid_return_type_for_catch_error
        .catchError((e) => log(
        "Error al pedir los mensajes particulares del usuario: " +
            e.toString()));


    final allData = querySnapshot.docs;

    List finalList = [];
    for (var data in allData) {
      finalList.add(QuestionModel(
          id: data.id,
          question: data['question']!,
          details: data['details']!,
          theme: data['theme']!,
          picture: data['picture']!,
          answer: data['answer']!,
          usuarioEnvia: data['usuarioEnvia']));
    }
    return finalList;
  }



  /* *******************************
      Obtener información del usuario autenticado
  * **********************************/

  Future<List<String>> getUserData() async{
    final DocumentSnapshot<Object?> response = await users.doc(uid).get();
    return <String>[response.get("name"), response.get("email")];
  }

  /* *******************************
      Obtener información del usuario por id
  * **********************************/

  Future<List<String>> getUserDataById(String userid) async {
    try{
      final DocumentSnapshot<Object?> response = await users.doc(userid).get();
      return <String>[response.get("name"), response.get("email")];
    }catch(e){
      log("Error al obtener la información de usuario por id de usuario: " + e.toString());
      return ["", ""];
    }
  }



  /* **********************************
  Métodos para manejar imágenes  en Firestorage
   * **********************************/

  //variables para subir imagenes
  UploadTask? imageTask;                                  //para monitorear la tarea de subir imagen
  FirebaseStorage fireStorage = FirebaseStorage.instance; //instancia de firestorage para hacer peticiones

  // método para subir imagenes a firestore
  Future uploadFile (String destination, File file, String messageId)async{

    try{

      Reference ref = fireStorage.ref(destination);
      imageTask = ref.putFile(file);

      // si no hay id de mensaje quiere decir que es una foto
      // de perfil la que se va a subir, de lo contrario
      // se asume que es un mensaje
      if (messageId == ''){
        users.doc(uid).update({"picture" : destination});
      }else{
        questions.doc(messageId).update({"picture" : destination});
      }

      return imageTask;

    }on FirebaseException catch (e){

      if(messageId == ''){
        log("En el evento de subir una foto de mensaje: ");
      } else {
        log("En el evento de subir una foto de perfil: ");
      }

      log("Hubo un error al subir la imagen a firebase: " + e.toString());
      return null;
    }

  }


  //este método es para borrar fotos de perfil que van a ser reemplazadas por otras

  Future updatePreviousProfilePic(String destination, File file) async{

    try{

      // obtiene toda la información del documento con id: "uid" de la colección "users"
      final DocumentSnapshot<Object?> response = await users.doc(uid).get();

      // obtiene una referencia a la imagen guardada en fireStorage con el nombre
      // del campo picture de la respuesta obtenida anteriormente, y la borra
      await fireStorage.ref().child(response.get("picture")).delete().whenComplete(() => log("imagen pasada" +
          " borrada con exito ")).catchError((e) => log("Error al borran imagen pasada " + e.toString()));

      Reference ref = fireStorage.ref(destination);
      imageTask = ref.putFile(file);

      users.doc(uid).update({"picture" : destination});

      return imageTask;

    }on FirebaseException catch (e){

      log("Hubo un error al subir la imagen a firebase: " + e.toString());
      return null;
    }

  }

  // Metodo para cargar la imagen de perfil al inciar sesión
  Future loadProfileImageOnStartup() async{

    try{
      // obtiene toda la información del documento con id: "uid" de la colección "users"
      final DocumentSnapshot<Object?> response = await users.doc(uid).get();

      // obtiene una referencia a la imagen guardada en fireStorage con el nombre
      // del campo picture de la respuesta obtenida anteriormente
      Reference ref = fireStorage.ref().child(response.get("picture"));

      // obtiene la url de referencia a esa imagen guardada
      String url = await ref.getDownloadURL();

      return url;
    }catch (e){
      log("Al momento de cargar la imagen en inicio de la app sucedió: " + e.toString());
    }

 }


 // Método para cargar imagen de algún mensaje
  Future<String> getImageFromMessage(String messageId) async{

    final DocumentSnapshot<Object?> response = await questions.doc(messageId).get();
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


  //ESTO NO SE ESTA USANDO PARA EL LOGIN!!! ASI SE METE INFO EN FIREBASE
  Future updateUserData(String name, String email, String picture) async {
    return await users.doc(uid).set({
      'name': name,
      "email": email,
      "picture": picture,
    });
  }



}
