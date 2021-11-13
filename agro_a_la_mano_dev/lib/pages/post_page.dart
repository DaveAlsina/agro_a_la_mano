//import 'package:ensayos/domain/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:agro_a_la_mano_dev/pages/comentarios_page.dart';
import 'package:get/get.dart';

Color verde = Colors.green[400]!;
Color gris = Colors.grey[350]!;

class Post extends StatelessWidget {
  final String _postContent =
      "Aquí va el contenido del post. Definir si hay un titular del Post o si todo va en un mismo body.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                color: verde,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Historial",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )
                  ],
                ),
              )),
          // T T Im Ic T
          Expanded(
              flex: 3,
              child: Column(children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "¿Cómo cultivar lechuga?",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Text(_postContent),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Image(image: AssetImage("img/lechuga.jpg")),
                ),
                SizedBox(
                  height: 30,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ComentariosPage()),
                      );
                    },
                    color: gris,
                    icon: Icon(
                      Icons.arrow_circle_down_rounded,
                      size: 25,
                    )),
                Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 20),
                    child: Text(
                      "Comentarios",
                      style: TextStyle(color: gris),
                    ))
              ])),
        ],
      ),
    );
  }
}
