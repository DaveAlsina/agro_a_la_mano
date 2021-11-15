import 'package:agro_a_la_mano_dev/data/repositories/models/question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

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

  Future<List> getDataQuestions() async {
    Query query = questions..where('usuarioEnvia', isEqualTo: uid);
    QuerySnapshot querySnapshot = await query.get();
    final allData = querySnapshot.docs;

    List finalList = [];
    for (var data in allData) {
      finalList.add(QuestionModel(
          id: data.id,
          question: data['question']!,
          details: data['details']!,
          theme: data['theme']!,
          picture: data['picture']!,
          answer: data['answer']!));
    }
    return finalList;
  }
}
