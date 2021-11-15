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
  LocalPreferences prefs = LocalPreferences();

  var _rows = <dynamic>[].obs;
  var _questionsByUser = [].obs;


  List<dynamic> get rows => _rows.value;


  //==========================================================================
  //Functionality using firebase
  Future<bool> saveQuestion(
      String pregunta, String detalles, String tema, String picture) async {
    String uid = _authController.uid;
    dynamic response = DatabaseService(uid: uid)
        .saveQuestionFirebase(pregunta, detalles, tema, picture);

    //Get all answers to display
    _rows.value = await DatabaseService(uid: uid).getDataQuestions();
    if (response == null) {
      log('No se pudo guardar la pregunta');
      return false;
    } else {
      log('pregunta guardada correctamente');
      return true;
    }
  }

  Future<bool> deleteQuestion(String messageId) async {
    String uid = _authController.uid;
    print('Id de la pregunta a borrar' + messageId.toString());
    await DatabaseService(uid: uid).deleteDocumentFirebase(messageId);
    return true;
  }

/*

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
      if(count != index)
        new_rows.add(register);
    }

    await prefs.storeData<List<RowLoc>>("rows", new_rows);
    _rows.value = new_rows;
    deleteQuestion(index);
  }


*/
}
