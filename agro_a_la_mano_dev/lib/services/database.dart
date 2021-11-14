import 'package:cloud_firestore/cloud_firestore.dart';

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
    return await questions.doc().set({
      'usuarioEnvia': uid,
      'question': pregunta,
      "details": detalles,
      "theme": tema,
      "picture": image,
      'answer': {},
    });
  }

  Future saveAnswerFirebase(String idRef, String mensaje) async {
    return await questions.doc(idRef).update({
      'answer': {
        'usuarioResponde': uid,
        'respuesta': mensaje,
      },
    });
  }

  Future deleteDocumentFirebase(String idRef) async {
    return await questions.doc(idRef).delete();
  }
}
