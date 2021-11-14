//paquetes de las páginas implementadas
import 'package:agro_a_la_mano_dev/pages/comentarios_page.dart';
import 'package:agro_a_la_mano_dev/pages/home_page.dart';
import 'package:agro_a_la_mano_dev/pages/questionhist_page.dart';
import 'package:agro_a_la_mano_dev/pages/profile_page.dart';
import 'package:agro_a_la_mano_dev/pages/questionask_page.dart';

// constantes de estilo
import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
    as Color_constants;
import 'package:firebase_core/firebase_core.dart';
import 'assets/icons.dart' as Icons_constants;

//Controladores
import 'package:agro_a_la_mano_dev/controllers/messages_controller.dart';
import 'package:agro_a_la_mano_dev/controllers/authentication_controller.dart';

//libs estándar
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthenticationController());
  Get.put(HistoryController());
  runApp(GetMaterialApp(
    home: HomePage(),
    getPages: [
      GetPage(
        name: '/QuestionPage',
        page: () => QuestionPage(),
        transition: Transition.leftToRight,
      ),
      GetPage(
          name: '/QuestionHistoryPage',
          page: () => QuestionHistoryPage(),
          transition: Transition.leftToRight,
          children: [
            GetPage(
              name: '/CommentPage',
              page: () => ComentariosPage(),
            )
          ]),
      GetPage(
        name: '/ProfilePage',
        page: () => ProfilePage(),
        transition: Transition.leftToRight,
      ),
    ],
  ));
}
