import 'package:agro_a_la_mano_dev/controllers/authentication_controller.dart';
import 'package:agro_a_la_mano_dev/controllers/authentication_controller.dart';
import 'package:agro_a_la_mano_dev/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
    as colorCons;
import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
    as textCons;
import 'package:agro_a_la_mano_dev/assets/icons.dart' as iconCons;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationController _authcontroller = Get.find();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: colorCons.BACKGROUND_COLOR,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Container(
                  height: 130,
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/images/brote.png'),
                ),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      height: 50,
                      child: Text(
                        '¡Bienvenido!',
                        style: TextStyle(
                            color: colorCons.BLUE_LETTERS_COLOR,
                            fontFamily: textCons.TEXT_FONT_CONST,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.all(5),
                      height: 30,
                      child: Text(
                        'Introduzca su correo y contraseña para ingresar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: colorCons.BLUE_LETTERS_COLOR,
                            fontFamily: textCons.TEXT_FONT_CONST,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    )
                  ])),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 30,
                    padding: EdgeInsets.all(17),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Introduzca su correo";
                            } else if (!value.contains('@')) {
                              return "Introduzca un correo valido";
                            }
                          },
                        ),
                      ],
                    ),
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                      height: 30,
                      padding: EdgeInsets.all(17),
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter password";
                              } else if (!value.contains(RegExp(r'[A-Z]'))) {
                                return "Debe usar mayusculas, minusculas y numeros";
                              } else if (!value.contains(RegExp(r'[0-9]'))) {
                                return "Debe usar numeros";
                              }
                            },
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
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          final form = _formKey.currentState;
                          form!.save();
                          if (form.validate()) {
                            bool logged = await _authcontroller.login(
                                _emailController.text,
                                _passwordController.text);
                            print(logged);
                            if (logged) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(content: Text('User ok')));
                              print('nais');
                            } else {
                              Get.defaultDialog(
                                  // titlePadding: EdgeInsets.fromLTRB(
                                  //     24.0, 20.0, 24.0, 24.0),
                                  radius: 4,
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      24.0, 20.0, 24.0, 24.0),
                                  title: 'Algo salio mal',
                                  middleText:
                                      'Su correo o contraseña no son correctos',
                                  cancel: Text('Ok',
                                      style: TextStyle(
                                          color:
                                              colorCons.GREEN_BUTTON_COLOR)));
                              // showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) =>
                              //         AlertDialog(
                              //           title: const Text('Algo salió mal'),
                              //           content: const Text(
                              //               'Su correo o contraseña no coinciden'),
                              //           actions: [
                              //             TextButton(
                              //                 onPressed: () =>
                              //                     Navigator.pop(context),
                              //                 child: Text('Ok',
                              //                     style: TextStyle(
                              //                         color: colorCons
                              //                             .GREEN_BUTTON_COLOR)))
                              //           ],
                              //         ));
                            }
                          }
                        },
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
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
                            RichText(
                                text: TextSpan(
                                    text: "Registrate",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontFamily: textCons.TEXT_FONT_CONST,
                                        color: colorCons.BLUE_LETTERS_COLOR,
                                        fontSize: 15),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print('click registrar');
                                        Get.to(() => SignupPage());
                                      }))
                          ],
                        ),
                      )
                    ],
                  ))
            ]),
          )),
    );
  }
}
