import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_a_la_mano_dev/controllers/messages_controller.dart';
import 'package:agro_a_la_mano_dev/data/local_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';


//estilos, colores, iconos
import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
as colorCons;
import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
as textCons;
import 'package:agro_a_la_mano_dev/assets/icons.dart' as Icons_constants;

//Botton Navigation Bar y Navigation Bar personalizados
import 'package:agro_a_la_mano_dev/ui/customBottomNavBar.dart';
import 'package:agro_a_la_mano_dev/ui/customAppBar.dart';




//import 'profile_page.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  final _questionController = TextEditingController();
  final _themeController = TextEditingController();
  HistoryController histController = Get.find<HistoryController>();

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(

        preferredSize: const Size.fromHeight(79.0),
        child: Container(
          decoration: const BoxDecoration(
            color: colorCons.GREEN_BUTTON_COLOR,
          ),
          child: AppBarContent('Haz una pregunta'),
        ),

      ),

      bottomNavigationBar: CustomBottomNavBar(),

      key: Key('QuestionScaffold'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 19,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(199, 50)),
                      child: 
                        TextFormField(
                          key: Key('Pregunta'),
                          controller: _searchController,
                          decoration: InputDecoration(labelText: 'Pregunta'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Pregunta invalida";
                            } else {
                              return "";
                            }
                          },
                      ),
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(199, 50)),
                      child: 
                        TextFormField(
                          key: Key('Detalles'),
                          controller: _questionController,
                          decoration: InputDecoration(labelText: 'Detalles'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Por favor detallanos";
                            } else  {
                              return "";
                            }
                          },
                      ),
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(199, 50)),
                      child: 
                        TextFormField(
                          key: Key('Tema'),
                          controller: _themeController,
                          decoration: InputDecoration(labelText: 'Tema (opcional)'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Pregunta de nuevo";
                            } else  {
                              RowLoc registro = new RowLoc(id:_searchController.text, question:_questionController.text, questioner:"", answer:"", answerer:"");
                              histController.addHistoryRegister(registro);
                              return "";
                            }
                          },
                      ),
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    Container(
                      width: 99.0,
                      height: 99.0,
                      child:
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.add_a_photo_outlined),
                              tooltip: 'Incluir imagen (opcional)',
                              onPressed: () {
                                setState(() {
                                
                                });
                              },
                            ),
                            Text('Incluir imagen (Opcional)', textAlign: TextAlign.center,),
                          ]
                        )
                    ),               
                    SizedBox(
                      height: 19,
                    ),
                    ElevatedButton(
                        key: Key('SubmitTema'),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          final form = _formKey.currentState;
                          form!.save();
                          if (form.validate()) {
                            bool value = true;
                          } else {
                            bool value = false;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          onPrimary: Colors.white,
                        ),
                        child: Text("Preguntar")),
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