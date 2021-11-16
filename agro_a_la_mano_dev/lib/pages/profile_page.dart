//librerias estándar
import 'package:agro_a_la_mano_dev/controllers/authentication_controller.dart';
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
import 'package:agro_a_la_mano_dev/widgets/update_name_password_fields.dart';



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
  late TextEditingController _passwordController = TextEditingController();
  AuthenticationController _authcontroller = Get.find();
  FileController _fileController = Get.find();


  Future<String> get usrName async {
    List<String> info = await _authcontroller.getUserInfo();
    return info[0];
  }


  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
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

                      // si no hay url de imagen de perfil entonces pone la imagen por defecto
                      child: Obx(() =>(
                          _fileController.profileImageUrl.value.isEmpty?
                          Image.asset(
                            'img/persona_avatar.jpg',
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ) : Image.network(
                            _fileController.profileImageUrl.value,
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          )
                      ),
                      ),
                    ),
                  ),

                  //BOTON PARA CAMBIAR LA IMAGEN DE PERFIL

                  TextButton(
                    onPressed: ()async{
                      bool response  = await _fileController.uploadProfilePic();
                      if(response){
                        Get.snackbar('Imagen Actualizada',
                          'Ahora tienes nueva foto de perfil.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: colorCons.LIGHT_GREEN_BUTTON_COLOR,
                        );
                      }
                    },
                    child: Text(
                      'Cambiar foto',
                      style: TextStyle(
                        fontFamily: textCons.TEXT_FONT_CONST,
                        color: colorCons.GREY_LETTERS_COLOR,
                      ),
                    ),
                  ),

                  NameAndPasswordFields(),
                  Spacer(),
                  Spacer(),

                  //BOTÓN PARA CERRAR SESIÓN

                  Flexible(
                    flex: 1,
                    child: TextButton(
                      onPressed: () async{
                        await _authcontroller.logout();
                      },
                      onLongPress: () => () {},
                      child: Text(
                        'Cerrar sesión',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: textCons.TEXT_FONT_CONST,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                        primary: Colors.white,
                        backgroundColor: Colors.brown,
                      ),
                    ),
                  ),
                ]),
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

