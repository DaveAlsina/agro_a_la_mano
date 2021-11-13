import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//estilos y colores
import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
as colorCons;


/*
ADAPTAR ESTA CLASE Y PONERLE ATRIBUTOS MODIFICABLES:
 */

class AppBarContent extends StatefulWidget {

  AppBarContent(this.AppBarTitle);
  String AppBarTitle = '';

  @override
  _AppBarContentState createState() => _AppBarContentState(AppBarTitle);
}

class _AppBarContentState extends State<AppBarContent> {

  String title = 'Perfil';

  _AppBarContentState(this.title);


  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),

          child: Row(
            children: <Widget>[
              Container(
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(height: 60,),
              const Spacer(flex: 4,),
            ],
          ),
        ),
      ],
    );
  }
}
