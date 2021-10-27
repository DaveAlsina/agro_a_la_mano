
import 'package:agro_a_la_mano_dev/data/controllers/userController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {

  runApp(MaterialApp(
    //home:TestUserModel(),
    home:TestUserController(),
  ));

}


class TestUserController extends StatelessWidget {
  TestUserController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserController usr = Get.put(UserController(1, 'a', 'b', 'c', 'd'));

    return GetMaterialApp(
      home: Scaffold(
            body: SafeArea(
              child: Column(
                  children: <Widget>[
                    Text("Informacion del usuario: "),
                    Text(usr.toString()),
                    SizedBox(height: 20,),

                    //Text("El nombre es: " + usr.name),
                    Obx(() => Text("El nombre es: " + usr.name)),
                    SizedBox(height: 20,),

                    TextButton(onPressed: (){
                        usr.changeName("Pienso luego existo");
                    }, child: Text('Clicameeee!'))
                  ],
              ),
            ),
      ),
    );
  }
}
