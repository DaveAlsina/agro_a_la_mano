import 'dart:developer';

import 'package:agro_a_la_mano_dev/controllers/authentication_controller.dart';
import 'package:agro_a_la_mano_dev/services/auth.dart';
import 'package:agro_a_la_mano_dev/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:agro_a_la_mano_dev/data/local_preferences.dart';

class RowLoc {
  String? id;
  String? question;
  String? questioner;
  String? answer;
  String? answerer;

  RowLoc(
      {required this.id,
      required this.question,
      required this.questioner,
      required this.answer,
      required this.answerer});
}

class HistoryController extends GetxController {
  //Llamo al controlador
  AuthenticationController _authController = Get.find();
  LocalPreferences prefs = LocalPreferences();

  //Variables observables
  var _rows = <RowLoc>[].obs;
  var _questionsByUser = [].obs;

  List<RowLoc> get rows => _rows.value;

  Future<void> addHistoryRegister(RowLoc new_register) async {
    _rows.value = await prefs.retrieveData<List<RowLoc>>("rows") ?? _rows.value;
    List<RowLoc> new_rows = _rows.value;
    new_rows.add(new_register);
    await prefs.storeData<List<RowLoc>>("rows", new_rows);
  }

  Future<void> deleteHistoryRegister(int index) async {
    _rows.value = await prefs.retrieveData<List<RowLoc>>("rows") ?? _rows.value;

    List<RowLoc> new_rows = <RowLoc>[];
    int count = 0;
    for (var register in _rows.value) {
      if (count != index) new_rows.add(register);
    }

    await prefs.storeData<List<RowLoc>>("rows", new_rows);
    _rows.value = new_rows;
    deleteQuestion(index);
  }

  //==========================================================================
  //Functionality using firebase
  Future<bool> saveQuestion(
      String pregunta, String detalles, String tema, String picture) async {
    String uid = _authController.uidLogged;
    dynamic response = DatabaseService(uid: uid)
        .saveQuestionFirebase(pregunta, detalles, tema, picture);

    //Get all answers to display
    _questionsByUser.value = await DatabaseService(uid: uid).getDataQuestions();
    if (response == null) {
      log('No se pudo guardar la pregunta');
      return false;
    } else {
      log('pregunta guardada correctamente');
      return true;
    }
  }

  Future<bool> deleteQuestion(int index) async {
    String uid = _authController.uidLogged;
    String idRef = _questionsByUser[index].id;
    print('Id de la pregunta a borrar' + idRef.toString());
    await DatabaseService(uid: uid).deleteDocumentFirebase(idRef);
    return true;
  }
}
