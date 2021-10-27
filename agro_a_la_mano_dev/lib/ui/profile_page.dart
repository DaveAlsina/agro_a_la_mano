//librerias estándar
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//estilos y colores
import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
as colorCons;

import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
as textCons;

import 'package:agro_a_la_mano_dev/assets/icons.dart' as Icons_constants;

//Botton Navigation Bar y Navigation Bar personalizados
import 'package:agro_a_la_mano_dev/ui/customBottomNavBar.dart';
import 'package:agro_a_la_mano_dev/ui/customAppBar.dart';
import 'package:get/get.dart';


/*
	Atributos:	-> No tiene atributos.

	Descripción: 	Esta es la implementación de la vista de la página del perfil
	              usuario.
*/


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _ = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
          body: Container(
            color: colorCons.BACKGROUND_COLOR,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[

                // IMAGEN DE PERFIL

                 Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  child: ClipOval(
                    child: Image.asset(
                      '../img/lechuga.jpg',
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),

                //BOTON PARA CAMBIAR LA IMAGEN DE PERFIL

                TextButton(

                      onPressed: (){},
                      child: Text('Cambiar foto',
                                style: TextStyle(fontFamily: textCons.TEXT_FONT_CONST,
                                                  color: colorCons.GREY_LETTERS_COLOR,),
                      ),
                  ),


                  SizedBox(height: 40,),

                  /*
                  Nombre y campo para cambiarlo
                   */

                  Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[


                        SizedBox(width: 40,),

                        Flexible(child:
                          Text('Nombre'),
                          flex: 2,
                        ),

                        SizedBox(width: 20,),

                          Flexible(
                              flex: 5,
                              child:
                              Container(
                                child:
                                  TextField(
                                    obscureText: true,
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Nombre del Usuario',
                                      suffixIcon: Icon(Icons.border_color_sharp, color: colorCons.GREY_LETTERS_COLOR,),
                                    ),
                                  ),
                              ),
                          ),

                        SizedBox(width: 40,),

                    ]
                  ),

                SizedBox(height: 10,),

                /*
                  Correo y campo para cambiarlo
                */

                Row(

                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: <Widget>[


                      SizedBox(width: 40,),

                      Flexible(child:
                      Text('Correo  '),
                        flex: 2,
                      ),

                      SizedBox(width: 20,),

                      Flexible(
                        flex: 5,
                        child:
                        Container(
                          child:
                          TextField(
                            obscureText: true,
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Usuario@correo.com',
                              suffixIcon: Icon(Icons.border_color_sharp, color: colorCons.GREY_LETTERS_COLOR,),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 40,),

                    ]
                ),

               Spacer(),
               Spacer(),

                //BOTÓN PARA CERRAR SESIÓN

                Flexible(
                  flex: 1,
                  child:
                  TextButton(
                      onPressed: () =>(){},
                      onLongPress: () => (){},
                      child: Text('Cerrar sesión',
                        style: TextStyle(fontWeight: FontWeight.bold,
                                          fontFamily: textCons.TEXT_FONT_CONST,
                        ),
                      ),
                     style: TextButton.styleFrom(
                       padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                       primary: Colors.white,
                       backgroundColor: Colors.black38,
                     ),
                  ),
                ),

              ]
            ),
          ),


        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Container(
            decoration: const BoxDecoration(
              color: colorCons.GREEN_BUTTON_COLOR,
            ),
            child: AppBarContent('Perfil'),
          ),
        ),

          bottomNavigationBar: CustomBottomNavBar(),

      ),
    );
  }
}


/*
class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 100, 100);
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}
*/