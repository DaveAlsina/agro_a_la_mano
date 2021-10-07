import 'package:flutter/material.dart';
import 'package:f_authentication_template/domain/controllers/authentication_controller.dart';
import 'package:f_authentication_template/data/repositories/local_preferences.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  final _questionController = TextEditingController();
  AuthenticationController controller = Get.find<AuthenticationController>();
  HistoryController histController = Get.find<HistoryController>();

  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('loginScaffold'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Bienvenido usuario X",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(200, 50)),
                      child: 
                        TextFormField(
                        key: Key('Busqueda'),
                        controller: _searchController,
                        decoration: InputDecoration(labelText: 'Buscar: Palabras clave o persona'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Busca de nuevo";
                          } else {
                            return "Realizando tu busqueda";
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        key: Key('SubmitBusqueda'),
                        onPressed: () async {
                          // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                          FocusScope.of(context).requestFocus(FocusNode());
                          final form = _formKey.currentState;
                          form!.save();
                          if (form.validate()) {
                            var value = await controller.login(
                                _searchController.text,
                                _questionController.text);
                            if (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('User ok')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('User problem')));
                            }
                          } else {
                            final snackBar = SnackBar(
                              content: Text('Validation nok'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text("Buscar")),
                    SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(200, 50)),
                      child: 
                        TextFormField(
                        key: Key('Pregunta'),
                        controller: _questionController,
                        decoration: InputDecoration(labelText: 'Realiza una pregunta'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Pregunta de nuevo";
                          } else  {
                            RowLoc registro = new RowLoc(id:value, question:value, questioner:"", answer:"", answerer:"");
                            //filas.add(registro);
                            histController.addHistoryRegister(registro);
                            return "Guardando a tu pregunta";
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        key: Key('SubmitPregunta'),
                        onPressed: () async {
                          // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                          FocusScope.of(context).requestFocus(FocusNode());
                          final form = _formKey.currentState;
                          form!.save();
                          if (form.validate()) {
                            //var value = await controller.login(_searchController.text,_questionController.text);
                            bool value = true;
                            if (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('User ok')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('User problem')));
                            }
                          } else {
                            final snackBar = SnackBar(
                              content: Text('Validation nok'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text("Preguntar")),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          key: Key('Historial'),
                          onPressed: () {
                            Get.to(() => ProfilePage());
                          },
                          child: Text("Historial de busqueda"))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
