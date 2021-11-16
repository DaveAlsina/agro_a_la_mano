import 'package:flutter/material.dart';
import 'package:agro_a_la_mano_dev/widgets/comment_box.dart';

//estilos y colores
import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
    as colorCons;

import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
    as textCons;

Color verde = Colors.green[400]!;
Color gris = Colors.grey[350]!;

class ComentariosPage extends StatefulWidget {
  const ComentariosPage({Key? key}) : super(key: key);

  @override
  _ComentariosPageState createState() => _ComentariosPageState();
}

// Aqui se debe hacer un query a los comentarios asociados a este post
class _ComentariosPageState extends State<ComentariosPage> {
  List<String> nombres = ["Juan Camilo Ruiz", "Dave Alsina"];
  List<bool> havePhoto = [false, false];
  List<String> contenidos = [
    "Hola mi nombre es JC Ruiz",
    "Hola, yo soy Dave Alsina"
  ];
  List<int> likesPorComentario = [0, 0];
  List<int> nRespPorComentario = [0, 0];
  List<String> codigos = ["C1", "C2"];
  List<String> fechas = ["17 mars 2021", "20 mars 2021"];
  List<String> horas = ["14:05", "11:30"];
  @override
  Widget build(BuildContext context) {
    // Es necesario lista de Widgets
    List<Widget> listaComentarios = [];
    for (var i = 0; i < nombres.length; i++) {
      listaComentarios.add(CommentBox(
          nombres[i],
          havePhoto[i],
          contenidos[i],
          likesPorComentario[i],
          nRespPorComentario[i],
          codigos[i],
          fechas[i],
          horas[i]));
    }
    return Scaffold(
        backgroundColor: colorCons.BACKGROUND_COLOR,
        appBar: AppBar(
            backgroundColor: colorCons.GREEN_BUTTON_COLOR,
            title: Text("Comentarios:")),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: nombres.length,
          itemBuilder: (BuildContext context, int index) {
            return CommentBox(
                nombres[index],
                havePhoto[index],
                contenidos[index],
                likesPorComentario[index],
                nRespPorComentario[index],
                codigos[index],
                fechas[index],
                horas[index]);
          },
        ));
  }
}
