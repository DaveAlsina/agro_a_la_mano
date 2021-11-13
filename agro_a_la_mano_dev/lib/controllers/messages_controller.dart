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
  LocalPreferences prefs = LocalPreferences();
  var _rows = <RowLoc>[].obs;

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
      if(count != index)
        new_rows.add(register);
    }

    await prefs.storeData<List<RowLoc>>("rows", new_rows);   
    _rows.value = new_rows;
  }
}
