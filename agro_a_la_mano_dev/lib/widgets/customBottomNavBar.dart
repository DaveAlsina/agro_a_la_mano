import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//estilos
import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
    as colorCons;
import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
    as textCons;
import 'package:agro_a_la_mano_dev/assets/icons.dart' as Icons_constants;
import 'package:agro_a_la_mano_dev/assets/custom_icons_icons.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 100,
      child: Row(
        children: <Widget>[
          Spacer(),
          IconButton(
            tooltip: 'Ayuda',
            icon: Icon(
              Icons.explore_outlined,
              color: colorCons.GREY_LETTERS_COLOR,
            ),
            onPressed: () {},
          ),
          Spacer(),
          IconButton(
            tooltip: 'Escribe una pregunta',
            icon: Icons_constants.WRITE_QUESTION_ICON,
            onPressed: () {
              Get.toNamed('/QuestionPage');
            },
          ),
          Spacer(),
          IconButton(
            tooltip: 'Home',
            icon: Image.asset('assets/images/brote.png'),
            onPressed: () {},
          ),
          Spacer(),
          IconButton(
            tooltip: 'Historial de preguntas',
            icon: Icons_constants.HISTORIAL_LIST_ICON,
            onPressed: () {
              Get.toNamed('/QuestionHistoryPage');
            },
          ),
          Spacer(),
          IconButton(
            tooltip: 'Ver perfil',
            icon: Icons_constants.PROFILE_ICON,
            onPressed: () {
              Get.toNamed('/ProfilePage');
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}
