import 'package:agro_a_la_mano_dev/controllers/authentication_controller.dart';
import 'package:agro_a_la_mano_dev/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
    as colorCons;
import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
    as textCons;
import 'package:agro_a_la_mano_dev/assets/icons.dart' as iconCons;
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationController _authcontroller = Get.find();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

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
                  child: Image.asset('brote.png'),
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
                        'Introduzca sus datos para registrarse',
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
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nombre',
                          style: TextStyle(
                              color: colorCons.GREY_LETTERS_COLOR,
                              fontFamily: textCons.TEXT_FONT_CONST),
                        ),
                        TextFormField(
                          controller: _nameController,
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
                              return "Enter name";
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
                    padding: EdgeInsets.all(10),
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
                              suffixIcon: iconCons.EMAIL_AT_ICON,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: colorCons.GREEN_BUTTON_COLOR,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter email";
                            } else if (!value.contains('@')) {
                              return "Entre un correo valido";
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
                      padding: EdgeInsets.all(10),
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
                          'SignUp',
                          style: TextStyle(
                              fontFamily: textCons.TEXT_FONT_CONST,
                              fontSize: 16),
                        ),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          final form = _formKey.currentState;
                          form!.save();
                          if (form.validate()) {
                            bool saved = await _authcontroller.signup(
                                _nameController.text,
                                _emailController.text,
                                _passwordController.text);
                            print(saved);
                            if (saved) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text('Bienvenido'),
                                        content: const Text(
                                            'Su usuario se ha guardado correctamente. Ingrese'),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Ok',
                                                  style: TextStyle(
                                                      color: colorCons
                                                          .GREEN_BUTTON_COLOR)))
                                        ],
                                      ));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text('Oh oh'),
                                        content: const Text(
                                            'Su usuario no se ha guardado correctamente. Intente de nuevo'),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Ok',
                                                  style: TextStyle(
                                                      color: colorCons
                                                          .GREEN_BUTTON_COLOR)))
                                        ],
                                      ));
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
                              'Ya tienes cuenta? ',
                              style: TextStyle(
                                  fontFamily: textCons.TEXT_FONT_CONST,
                                  color: colorCons.GREY_LETTERS_COLOR,
                                  fontSize: 15),
                            ),
                            RichText(
                                text: TextSpan(
                                    text: "Ingresa",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontFamily: textCons.TEXT_FONT_CONST,
                                        color: colorCons.BLUE_LETTERS_COLOR,
                                        fontSize: 15),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print('click ingresa');
                                        Navigator.pop(context);
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