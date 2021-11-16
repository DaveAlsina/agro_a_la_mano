import 'dart:developer';

import 'package:agro_a_la_mano_dev/data/repositories/models/question_model.dart';
import 'package:agro_a_la_mano_dev/services/database.dart';
import 'package:get/get.dart';
import 'package:agro_a_la_mano_dev/data/local_preferences.dart';

import 'package:agro_a_la_mano_dev/data/repositories/models/row_loc_model.dart';
import 'authentication_controller.dart';


class HistoryController extends GetxController {
  //Llamo al controlador
  AuthenticationController _authController = Get.find();

  var currentQuestionIdx = [-1].obs;
  var _rows = <dynamic>[].obs;

  List<dynamic> get rows => _rows.value;
  QuestionModel get currentQuestionInfo => this._rows[this.currentQuestionIdx[0]];


  HistoryController() {
    onInit();
  }
  //==========================================================================
  //Functionality using firebase

  void onInit() async {
    String uid = _authController.uid;
    _rows.value = await DatabaseService(uid: uid).getDataQuestions();
  }

  Future<String> saveQuestion(
    String pregunta, String detalles, String tema, String picture) async {

    String uid = _authController.uid;

    String response = await DatabaseService(uid: uid)
      .saveQuestionFirebase(pregunta, detalles, tema, picture);

    //Get all answers to display
    _rows.value = await DatabaseService(uid: uid).getDataQuestions();

    if (response == null) {
        log('No se pudo guardar la pregunta');
        return 'xxxx';
    } else {
        log('pregunta guardada correctamente');
        return response;
    }
  }

  Future<bool> deleteQuestion(String messageId) async {
    String uid = _authController.uid;
    print('Id de la pregunta a borrar' + messageId.toString());
    await DatabaseService(uid: uid).deleteDocumentFirebase(messageId);
    return true;
  }


  void changeCurrentQuestionIdx(int idx){
    currentQuestionIdx[0] = idx;
    refresh();
  }

  // Guarda respuesta a mensaje
  Future<bool> saveResponseQuestion(String idRef, String message) async {

    String uid = _authController.uid;

    bool? response = await DatabaseService(uid: uid).saveAnswerFirebase(idRef, message);

    if (response == null) {
      log('No se pudo guardar la respuesta a la pregunta');
      return false;
    } else {
      log('respuesta a pregunta guardada correctamente');
      return true;
    }
  }



}
