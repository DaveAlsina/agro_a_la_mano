import 'package:flutter/material.dart';
import 'package:get/get.dart';

//para hacer pruebas sencillas de inicialización y métodos
//import 'package:agro_a_la_mano_dev/data/models/testUserModel.dart';

import 'package:agro_a_la_mano_dev/data/controllers/testUserController.dart';
import 'data/controllers/userController.dart';


Future<void> main() async {


  runApp(MaterialApp(
    //home:TestUserModel(),
    home:TestUserController(),
  ));

}


class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(),
    );
  }

}






