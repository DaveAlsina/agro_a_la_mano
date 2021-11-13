import 'package:agro_a_la_mano_dev/controllers/files_controller.dart';
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
import 'package:agro_a_la_mano_dev/widgets/customBottomNavBar.dart';
import 'package:agro_a_la_mano_dev/widgets/customAppBar.dart';

//import 'profile_page.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final _formKey = GlobalKey<FormState>();
  final _detailsController = TextEditingController();
  final _questionController = TextEditingController();
  final _themeController = TextEditingController();
  HistoryController histController = Get.find<HistoryController>();

  // nuevo
  FileController _fileController = Get.find();

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
                      child: TextFormField(
                        key: Key('Pregunta'),
                        controller: _questionController,
                        decoration: InputDecoration(
                            labelText: 'Pregunta',
                            //suffixIcon: Icon(Icons.search),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorCons.GREEN_BUTTON_COLOR,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                      ),
                    ),

                    SizedBox(
                      height: 19,
                    ),

                    ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(199, 50)),
                      child: TextFormField(
                        key: Key('Detalles'),
                        controller: _detailsController,
                        decoration: InputDecoration(
                            labelText: 'Detalles',
                            //suffixIcon: Icon(Icons.search),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorCons.GREEN_BUTTON_COLOR,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                      ),
                    ),

                    SizedBox(
                      height: 19,
                    ),

                    ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(199, 50)),
                      child: TextFormField(
                        key: Key('Tema'),
                        controller: _themeController,
                        decoration: InputDecoration(
                            labelText: 'Tema (opcional)',
                            //suffixIcon: Icon(Icons.search),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorCons.GREEN_BUTTON_COLOR,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                      ),
                    ),

                    SizedBox(
                      height: 19,
                    ),

                    Container(
                        width: 99.0,
                        height: 99.0,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            icon: Icon(Icons.add_a_photo_outlined),
                            tooltip: 'Incluir imagen (opcional)',
                            onPressed: () async{

                              bool response1  = await _fileController.browseFiles();

                              if(response1){
                                Get.snackbar('Imagen Añadida',
                                  'La imagen de tu mensaje ha sido añadida',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: colorCons.LIGHT_GREEN_BUTTON_COLOR,
                                );

                              }

                            },
                          ),

                          Text(
                            'Incluir imagen (Opcional)',
                            textAlign: TextAlign.center,
                          ),
                        ])),

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

                            if (_questionController.text == "")
                              return;
                            else if (_detailsController.text == "") return;
                            RowLoc registro = new RowLoc(
                                id: _questionController.text,
                                question: _detailsController.text,
                                questioner: "",
                                answer: "",
                                answerer: "");
                            histController.addHistoryRegister(registro);

                            //nuevo
                            bool response2 = await _fileController.uploadFile();
                            Get.snackbar('Mensaje Enviado!', '');

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
