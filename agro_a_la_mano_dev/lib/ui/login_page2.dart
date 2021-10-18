import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
    as colorCons;
import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
    as textCons;
import 'package:agro_a_la_mano_dev/ui/icons.dart' as iconCons;

class LoginPage2 extends StatefulWidget {
  const LoginPage2({Key? key}) : super(key: key);

  @override
  _LoginPageState2 createState() => _LoginPageState2();
}

class _LoginPageState2 extends State<LoginPage2> {
  // final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: colorCons.BACKGROUND_COLOR,
      home: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Container(
                  height: 100,
                  child: Image.asset('brote.png'),
                ),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: Column(children: [
                    Container(
                      height: 100,
                      child: Text(
                        '¡Bienvenido!',
                        style: TextStyle(
                            color: colorCons.BLUE_LETTERS_COLOR,
                            fontFamily: textCons.TEXT_FONT_CONST,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Text(
                      'Introduzca su correo y contraseña para ingresar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: colorCons.BLUE_LETTERS_COLOR,
                          fontFamily: textCons.TEXT_FONT_CONST,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    ),
                  ])),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 100,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                  fit: FlexFit.tight,
                  child: Container(
                      height: 100,
                      padding: EdgeInsets.all(5),
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
                  fit: FlexFit.tight,
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
                        padding: EdgeInsets.all(3.75),
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
            ]),
      ),
    );
  }
}
