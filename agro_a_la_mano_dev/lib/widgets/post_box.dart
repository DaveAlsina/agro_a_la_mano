import 'package:agro_a_la_mano_dev/controllers/feed_controller.dart';
import 'package:agro_a_la_mano_dev/pages/comentarios_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//estilos, colores, iconos
import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
as colorCons;
import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
as textCons;
import 'package:agro_a_la_mano_dev/assets/icons.dart' as Icons_constants;
import 'package:get/get.dart';

//import 'package:get/get.dart';
//import 'package:ensayos/clases/comentario.dart';

class PostBox extends StatelessWidget {
  // De esta forma puede entrar cualquier argumento a la clase
  @override
  PostBox(this.id, this.autor, this.hasPhoto, this.pregunta, this.contenido, this.tema);

  FeedController controller = Get.find();

  final int id;
  final String autor;
  final String hasPhoto;
  final String pregunta;
  final String contenido;
  final String tema;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Card(
        color: colorCons.BACKGROUND_COLOR,
        elevation: 0.5,
        // mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.start,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.all(2),
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('../img/persona_avatar.jpg'),
                  )),
            ),
            Expanded(
                flex: 8,
                child: Container(
                  // borde de la parte derecha
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Para nombre de persona
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    this.autor,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: textCons.TEXT_FONT_CONST),
                                  ),
                                ),
                                // Contenido de su post
                                Container(
                                    height: 40,
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(this.pregunta)),
                                Flexible(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 50,
                                          child: Text(this.contenido,
                                              style: TextStyle(
                                                color: colorCons
                                                    .GREY_LETTERS_COLOR,
                                              )),
                                        ),
                                        Container(
                                          child: Text("Tem??tica: " + this.tema,
                                              style: TextStyle(
                                                color: colorCons
                                                    .GREY_LETTERS_COLOR,
                                              )),
                                        ),
                                      ],
                                    )),
                                Flexible(
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.thumb_up,
                                                color: colorCons.GREY_LETTERS_COLOR,
                                              )),
                                          IconButton(
                                            onPressed: () {
                                              controller.changeCurrentQuestionIdx(id);
                                              Get.to(ComentariosPage());
                                            },
                                            icon: Icon(Icons.add_comment),
                                            color: colorCons.GREY_LETTERS_COLOR,
                                          )
                                        ]))
                              ],
                            )),

                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}