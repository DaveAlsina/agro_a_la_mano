import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
    as colorCons;
import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
    as textCons;
import 'package:agro_a_la_mano_dev/ui/icons.dart' as iconCons;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: colorCons.BACKGROUND_COLOR,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    child: Image.asset(
                      'brote.png',
                      // scale: 0.2,
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: Container(
                    child: Text(
                      '¡Bienvenido!',
                      style: TextStyle(
                          color: colorCons.BLUE_LETTERS_COLOR,
                          fontFamily: textCons.TEXT_FONT_CONST,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Introduzca su correo y contraseña para ingresar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: colorCons.BLUE_LETTERS_COLOR,
                          fontFamily: textCons.TEXT_FONT_CONST,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Correo',
                          style: TextStyle(
                              color: colorCons.GREY_LETTERS_COLOR,
                              fontFamily: textCons.TEXT_FONT_CONST),
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              suffixIcon: iconCons.PROFILE_ICON,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: colorCons.GREEN_BUTTON_COLOR,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Enter email";
                          //   } else if (!value.contains('@')) {
                          //     return "Enter valid email address";
                          //   }
                          // },
                        ),
                      ],
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contraseña',
                            style: TextStyle(
                                color: colorCons.GREY_LETTERS_COLOR,
                                fontFamily: textCons.TEXT_FONT_CONST),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                suffixIcon: iconCons.LOCK_ICON,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: colorCons.GREEN_BUTTON_COLOR,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                )),
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return "Enter email";
                            //     } else if (!value.contains('@')) {
                            //       return "Enter valid email address";
                            //     }
                            //   },
                          ),
                        ],
                      ))),
              Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      MaterialButton(
                        minWidth: 150.0,
                        height: 50,
                        color: colorCons.GREEN_BUTTON_COLOR,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontFamily: textCons.TEXT_FONT_CONST,
                              fontSize: 16),
                        ),
                        onPressed: () {},
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Aun no tienes cuenta? ',
                              style: TextStyle(
                                  fontFamily: textCons.TEXT_FONT_CONST,
                                  color: colorCons.GREY_LETTERS_COLOR,
                                  fontSize: 15),
                            ),
                            Text(
                              'Registrate',
                              style: TextStyle(
                                  fontFamily: textCons.TEXT_FONT_CONST,
                                  color: colorCons.BLUE_LETTERS_COLOR,
                                  fontSize: 15),
                            )
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
