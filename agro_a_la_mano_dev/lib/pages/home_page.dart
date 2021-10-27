import 'package:agro_a_la_mano_dev/controllers/authentication_controller.dart';
import 'package:agro_a_la_mano_dev/pages/login_page.dart';
import 'package:agro_a_la_mano_dev/pages/questionask_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  AuthenticationController auth = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (auth.logged) {
        return GetMaterialApp(home: QuestionPage());
      } else {
        return LoginPage();
      }
    });
  }
}
