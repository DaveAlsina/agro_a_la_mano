import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() => runApp(GetMaterialApp( home: NameAndPasswordFields(),  ));



class NameAndPasswordFields extends StatefulWidget {
  const NameAndPasswordFields({Key? key}) : super(key: key);

  @override
  _NameAndPasswordFieldsState createState() => _NameAndPasswordFieldsState();
}

class _NameAndPasswordFieldsState extends State<NameAndPasswordFields> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
            key: formKey,
            child: Column(
                        children: <Widget>[
                          buildUsername(),

                          SizedBox(
                            height: 20,
                          ),

                          buildPassword(),
                        ],
                    ),
          ),
          
    );
  }

  /* **************************************************
    Campo de texto para ingresar el nombre de usuario
   * **************************************************/

  Widget buildUsername() => TextFormField(
      decoration: InputDecoration(
        labelText: "Nombre de usuario",
        border: OutlineInputBorder(),
      ),

      validator: (value){
        if(value!.length < 5){
          return 'Ingrese al menos 5 caractes';

        } else {
          return null;
        }

      },

  );

  /* ********************************************
      Campo de texto para ingresar la contraseña
   * ********************************************/

  Widget buildPassword() => TextFormField(
    obscureText: true,
    decoration: InputDecoration(
      labelText: "Contraseña",
      border: OutlineInputBorder(),
    ),

    validator: (value){
      if(value!.length < 6){
        return 'Ingrese al menos 6 caractes';

      } else {
        return null;
      }

    },

  );

}

