//librerias estándar
import 'package:agro_a_la_mano_dev/controllers/authentication_controller.dart';
import 'package:agro_a_la_mano_dev/controllers/feed_controller.dart';
import 'package:agro_a_la_mano_dev/pages/post_page.dart';
import 'package:agro_a_la_mano_dev/widgets/post_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//estilos y colores
import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
    as colorCons;

import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
    as textCons;

//Botton Navigation Bar y Navigation Bar personalizados
import 'package:agro_a_la_mano_dev/widgets/customBottomNavBar.dart';
import 'package:agro_a_la_mano_dev/widgets/customAppBar.dart';
import 'package:get/get.dart';

// librerias nuevas desde 12 de Nov
import 'package:agro_a_la_mano_dev/controllers/files_controller.dart';

/*
	Atributos:	-> No tiene atributos.

	Descripción: 	Esta es la implementación de la vista de la página de feed
*/

class FeedPage extends StatelessWidget {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  AuthenticationController _authcontroller = Get.find();
  FileController _fileController = Get.find();
  FeedController _feedController = Get.put(FeedController());

  Future<String> get usrName async {
    List<String> info = await _authcontroller.getUserInfo();
    return info[0];
  }

  @override
  Widget build(BuildContext context) {
    List<PostBox> postList = [];
    int i = 0;
    for (var post in _feedController.feedList) {
      // String userName = _feedController.namesList[i];
      // print("AQUI ESTA EL NOMBRE DE USUARIO WIU WIU " + userName);
      postList.add(PostBox(
          "userNam", post.picture, post.question, post.details, post.theme));
      i += 1;
    }
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorCons.BACKGROUND_COLOR,
        body: Container(
            color: colorCons.BACKGROUND_COLOR,
            child: Column(
              children: [
                Center(
                    heightFactor: 3,
                    child: Container(
                      // color: ,
                      child: Text(
                        'Preguntas de la comunidad',
                        style: TextStyle(
                            color: colorCons.BLUE_LETTERS_COLOR,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(
                    child: SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: postList,
                  ),
                ))
              ],
            )),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Container(
            decoration: const BoxDecoration(
              color: colorCons.GREEN_BUTTON_COLOR,
            ),
            child: AppBarContent('Feed'),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(),
      ),
    );
  }
}
