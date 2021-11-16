import 'package:agro_a_la_mano_dev/controllers/authentication_controller.dart';
import 'package:agro_a_la_mano_dev/data/repositories/models/question_model.dart';
import 'package:agro_a_la_mano_dev/services/database.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {
  AuthenticationController _authController = Get.find();
  late DatabaseService databaseService;

  //Variables observables
  var _feedList = <dynamic>[].obs;
  var currentQuestionIdx = [-1].obs;
  var _idUserList = [];

  List<dynamic> questionComments = [];


  QuestionModel get currentQuestionInfo => this._feedList[this.currentQuestionIdx[0]];

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


  void changeCurrentQuestionIdx(int idx) async{
    currentQuestionIdx[0] = idx;
    questionComments = await getCommentsFromMessage(this.currentQuestionInfo.id);
    databaseService = DatabaseService(uid: _authController.uid);

    List<dynamic> completeQuestionComments = [];

    for (dynamic comment in questionComments){
      comment["username"] = await databaseService.getUserDataById(comment["usuarioResponde"]);
      comment["username"] = comment["username"][0];
      completeQuestionComments.add(comment);
    }

    questionComments = completeQuestionComments;
    refresh();
  }

  Future<List<dynamic>> getCommentsFromMessage(String messageId)async{
    String uid = _authController.uid;
    return await DatabaseService(uid: uid).getCommentsFromMessage(messageId);
  }



}