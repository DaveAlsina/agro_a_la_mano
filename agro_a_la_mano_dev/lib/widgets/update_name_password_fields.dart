import 'dart:developer';

import 'package:agro_a_la_mano_dev/controllers/authentication_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
as colorCons;

import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
as textCons;



//void main() => runApp(GetMaterialApp( home: NameAndPasswordFields(),  ));


/*
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthenticationController auth = Get.put(AuthenticationController());
  //await Get.put(HistoryController());
  //await Get.put(NotificationsController());

  runApp(GetMaterialApp(home: Scaffold(body: NameAndPasswordFields()),));
}

 */


class NameAndPasswordFields extends StatefulWidget {
  const NameAndPasswordFields({Key? key}) : super(key: key);

  @override
  _NameAndPasswordFieldsState createState() => _NameAndPasswordFieldsState();
}

class _NameAndPasswordFieldsState extends State<NameAndPasswordFields> {

  AuthenticationController userInfoController = Get.find();
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return
       Form(

        key: formKey,
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: 40,),

            // *************************************
            // Fila del campo de Nombre de usuario
            // *************************************


            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                SizedBox(width: 20,),

                Flexible(

                  child: Text('Nombre      '),
                  flex: 2,
                ),

                Flexible(
                  flex: 5,
                  child: buildUsername(),
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),


            // ******************************************
            // Fila del campo de contraseña de usuario
            // ******************************************

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                SizedBox(width: 20,),

                Flexible(
                    flex: 2,
                    child: Text("Contraseña    ")
                ),

                Flexible(
                  flex: 6,
                  child: buildPassword(),
                ),

                SizedBox(width: 20,),

              ],
            ),

            SizedBox(height: 40,),

            MaterialButton(
              minWidth: 150.0,
              height: 35,
              color: colorCons.GREEN_BUTTON_COLOR,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              child: Text(
                'Actualizar Información',
                style: TextStyle(
                    fontFamily: textCons.TEXT_FONT_CONST,
                    fontSize: 16),
              ),
              onPressed: ()async{

                  final form = formKey.currentState;
                  form!.save();
                  if (form.validate()) {
                    log("El nombre de usuario y contraseña ingresados son válidos");
                    await userInfoController.changeUserPassword(passwordController.text);
                  }
              }
            ),




            ],
        ),

      );

  }

  /* **************************************************
    Campo de texto para ingresar el nombre de usuario
   * **************************************************/

  Widget buildUsername() => TextFormField(
    controller: nameController,
    decoration: InputDecoration(
      labelText: "Nombre de usuario",
      border: OutlineInputBorder(),
      suffixIcon: Icon(
        Icons.border_color_sharp,
        color: colorCons.GREY_LETTERS_COLOR,
      ),
    ),

    validator: (value){
        value = value!.trim();

        if(value.isEmpty) {
          log("No se va a cambiar el nombre de usuario");
          return null;
        }

        if (value.length < 5){
          return 'Ingrese al menos 5 caractes';
        }

    },

  );

  /* ********************************************
      Campo de texto para ingresar la contraseña
   * ********************************************/

  Widget buildPassword() => TextFormField(
    controller: passwordController,
    obscureText: true,
    decoration: InputDecoration(
      labelText: "Contraseña",
      border: OutlineInputBorder(),
      suffixIcon: Icon(
        Icons.border_color_sharp,
        color: colorCons.GREY_LETTERS_COLOR,
      ),

    ),

    validator: (value) {
      if (value!.isEmpty) {
        return "Enter password";
      } else if (!value.contains(RegExp(r'[A-Z]'))) {
        return "Debe usar mayusculas, minusculas \n y numeros";
      } else if (!value.contains(RegExp(r'[0-9]'))) {
        return "Debe usar numeros";
      } else if (value.length < 6) {
        return "Mínimo 6 caracteres";
      }
    },

  );

}