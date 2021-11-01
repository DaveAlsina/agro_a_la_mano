import 'package:agro_a_la_mano_dev/domain/controllers/authentication_controller.dart';
import 'package:agro_a_la_mano_dev/ui/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  AuthenticationController auth = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Obx(() {
        if (auth.logged) {
          return Column();
        } else {
          return LoginPage();
        }
      }),
    );
  }
}
