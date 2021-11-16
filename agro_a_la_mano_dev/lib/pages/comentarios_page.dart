import 'dart:developer';

import 'package:agro_a_la_mano_dev/controllers/feed_controller.dart';
import 'package:agro_a_la_mano_dev/controllers/messages_controller.dart';
import 'package:agro_a_la_mano_dev/widgets/post_box.dart';
import 'package:flutter/material.dart';
import 'package:agro_a_la_mano_dev/widgets/comment_box.dart';

//estilos y colores
import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
as colorCons;

import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
as textCons;
import 'package:get/get.dart';

Color verde = Colors.green[400]!;
Color gris = Colors.grey[350]!;


class ComentariosPage extends StatelessWidget {


  HistoryController historyController = Get.find();
  FeedController feedController = Get.find();

  final formKey = GlobalKey<FormState>();
  final responseController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colorCons.BACKGROUND_COLOR,
      appBar: AppBar(
          backgroundColor: colorCons.GREEN_BUTTON_COLOR,
          title: Text("Comentarios:")),
      body: Column(
        children: <Widget>[

          Form(
            key: formKey,
            child: Column(
              children: <Widget>[

                Container(padding: EdgeInsets.all(10),
                  child: buildResponseBox(),
                ),

                MaterialButton(
                    minWidth: 150.0,
                    height: 35,
                    color: colorCons.GREEN_BUTTON_COLOR,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    child: Text(
                      'Enviar Comentario',
                      style: TextStyle(
                          fontFamily: textCons.TEXT_FONT_CONST,
                          fontSize: 16),
                    ),
                    onPressed: ()async{

                      final form = formKey.currentState;
                      form!.save();
                      if (form.validate()) {
                        log("Comentario valido");
                         historyController.saveResponseQuestion(feedController.currentQuestionInfo.id,
                                                          responseController.text);
                      }
                    }
                ),

              ],
            ),
          ),

        Expanded(
          child: ListView.builder(
              itemCount: feedController.questionComments.length,
              itemBuilder: (BuildContext context, int idx){
                return ListTile(
                  title: Text(feedController.questionComments[idx]["respuesta"] + "\n" + feedController.questionComments[idx]["username"]),
                );
              }
          ),
        ),


        ],
      ),
    );
  }


  Widget buildResponseBox() => TextFormField(
    controller: responseController,
    decoration: InputDecoration(
      labelText: "Ingresa tu comentario",
      border: OutlineInputBorder(),
      suffixIcon: Icon(
        Icons.border_color_sharp,
        color: colorCons.GREY_LETTERS_COLOR,
      ),
    ),

    validator: (value){
      value = value!.trim();
      if(value == '') {
        return 'No hay mensaje que enviar';
      }else{
        return null;
      }

    },

  );


}

/*

                  ListView.separated(
                    padding: const EdgeInsets.all(8),
                    separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return PostBox("", "", "", "", "haytema");
                },
              )



 */