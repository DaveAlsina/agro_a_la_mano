import 'package:agro_a_la_mano_dev/pages/questionask_page.dart';
import 'package:agro_a_la_mano_dev/pages/questionhist_page.dart';
import 'package:agro_a_la_mano_dev/ui/profile_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//estilos
import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
as colorCons;
import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
as textCons;
import 'package:agro_a_la_mano_dev/assets/icons.dart' as Icons_constants;
import 'package:agro_a_la_mano_dev/assets/custom_icons_icons.dart' ;

import 'package:get/get.dart';


class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  BottomAppBar(
      color: Colors.white,
      elevation: 100,
      child: Row(
        children: <Widget>[

          Spacer(),

          IconButton(
            tooltip: 'Ayuda',
            icon: Icon(Icons.explore_outlined, color: colorCons.GREY_LETTERS_COLOR,),
            onPressed: () {

            },
          ),

          Spacer(),

          IconButton(
            tooltip: 'Escribe una pregunta',
            icon: Icons_constants.WRITE_QUESTION_ICON,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuestionPage()),
              );
            },
          ),


          Spacer(),

          IconButton(
            tooltip: 'Home',
            icon: Icon(CustomIcons.icono2),
            onPressed: () {},
          ),


          Spacer(),

          IconButton(
            tooltip: 'Historial de preguntas',
            icon: Icons_constants.HISTORIAL_LIST_ICON,
            onPressed: () {
              //Get.to(() => GetMaterialApp( home: QuestionHistoryPage() ));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuestionHistoryPage()),
              );
              //Navigator.push(context, );
            },
          ),

          Spacer(),

          IconButton(
            tooltip: 'Ver perfil',
            icon: Icons_constants.PROFILE_ICON,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),

          Spacer(),
        ],
      ),
    );

  }
}
