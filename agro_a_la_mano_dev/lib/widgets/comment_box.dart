import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';
//import 'package:ensayos/clases/comentario.dart';

class CommentBox extends StatelessWidget {
  // De esta forma puede entrar cualquier argumento a la clase
  @override
  CommentBox(this.autor, this.hasPhoto, this.contenido, this.nLikes,
      this.nRespuestas, this.id, this.fecha, this.hora);

  final String autor;
  final bool hasPhoto;
  final String contenido;
  final int nLikes;
  final nRespuestas;
  final String id; // identificador unico del comentario
  final String fecha;
  final String hora;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage('../img/persona_avatar.jpg'),
                )),
          ),
          Expanded(
              flex: 10,
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Contenido de su post
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(this.contenido))
                            ],
                          )),
                      // Parte baja de los likes, comentarios y respuesta a comentario
                      Expanded(
                        flex: 1,
                        child: Container(
                            //color: Colors.red[500],
                            alignment: Alignment.centerRight,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(this.fecha,
                                      style: TextStyle(
                                        color: Colors.grey[350],
                                      )),
                                  Text(this.hora,
                                      style: TextStyle(
                                        color: Colors.grey[350],
                                      )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.thumb_up)),
                                  Text(this.nLikes.toString()),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.add_comment))
                                ])),
                      ),
                    ],
                  ))),
        ],
      ),
    );
  }
}
