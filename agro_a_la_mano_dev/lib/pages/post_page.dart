//import 'package:ensayos/domain/controllers/authentication_controller.dart';
import 'package:agro_a_la_mano_dev/controllers/files_controller.dart';
import 'package:agro_a_la_mano_dev/controllers/messages_controller.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:agro_a_la_mano_dev/pages/comentarios_page.dart';
import 'package:get/get.dart';

Color verde = Colors.green[400]!;
Color gris = Colors.grey[350]!;

class Post extends StatelessWidget {
  HistoryController questionController = Get.find();
  FileController imageController = Get.find();
  late String _postContent;

  Post(){
      _postContent = questionController.currentQuestionInfo.details;
      imageController.loadMessageImageOnRequest(questionController.currentQuestionInfo.id);
  }


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
                        onPressed: () {
                          Get.back();
                        },
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
                    questionController.currentQuestionInfo.question,
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
                  child: Obx(() => imageController.messageImageUrl.value.isEmpty?
                                    Image.asset("img/lechuga.jpg"):
                                    Image.network(
                                        imageController.messageImageUrl.value,
                                        fit: BoxFit.cover,
                                        width: 300,
                                        height: 300,
                                    )
                            ),
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
