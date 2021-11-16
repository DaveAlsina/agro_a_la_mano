import 'package:agro_a_la_mano_dev/controllers/authentication_controller.dart';
import 'package:agro_a_la_mano_dev/services/database.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {
  AuthenticationController _authController = Get.find();
  //Variables observables
  var _feedList = <dynamic>[].obs;
  var _idUserList = [];

  FeedController() {
    init();
  }

  List<dynamic> get feedList => _feedList;
  List get namesList => _idUserList;
//============================FUNCTIONS======================
  void init() async {
    await getFeedQuestions();
    for (var post in _feedList) {
      await getUserNameById(post);
    }
  }

  Future getFeedQuestions() async {
    String uid = _authController.uid;
    _feedList.value = await DatabaseService(uid: uid).getFeedQuestions();
  }

  Future getUserNameById(dynamic post) async {
    List<String> list =
        await _authController.getUserInfoById(post.usuarioEnvia);
    String name = list[0];
    _idUserList.add(name);
  }
}
