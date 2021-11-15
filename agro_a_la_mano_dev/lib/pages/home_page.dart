import 'package:flutter/material.dart';
import 'package:get/get.dart';

//estilos, colores, iconos
import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
as colorCons;
import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
as textCons;
import 'package:agro_a_la_mano_dev/assets/icons.dart' as Icons_constants;

//Botton Navigation Bar y Navigation Bar personalizados
import 'package:agro_a_la_mano_dev/widgets/customBottomNavBar.dart';
import 'package:agro_a_la_mano_dev/widgets/customAppBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {  
    @override
    Widget build(BuildContext context) {
        NotificationsController notificationsController = Get.find();
        return Scaffold(
            backgroundColor: colorCons.BACKGROUND_COLOR,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(79.0),
                child: Container(
                decoration: const BoxDecoration(
                    color: colorCons.GREEN_BUTTON_COLOR,
                ),
                child: AppBarContent('Pagina principal'),
                ),
            ),

            bottomNavigationBar: CustomBottomNavBar(),

            body: Column(
                children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                            "Bienvenido usuario:",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                        ),
                    ),
                    SizedBox(
                        width: 300.0,
                        height: 200.0,
                        child: Align(
                            alignment: Alignment.center,
                            child: _buildProfileImage(),
                        ),
                    ),
                    Container(
                        decoration: const BoxDecoration(
                            color: colorCons.GREEN_BUTTON_COLOR,
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        child: Text(
                                "Última actividad",
                                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,),
                        ),
                    ),
                    SizedBox(
                        width: 300.0,
                        height: 20.0,
                    ),
                    Container(
                        child: Center(
                            child: SizedBox(
                                    width: 300.0,
                                    height: 200.0,
                                    child: _updateNotifications(),
                            ) 
                        ),
                    ),
                ],
            ),
        );
    }

    Widget _buildProfileImage() => CircleAvatar(
        radius: 80,
        backgroundColor: Colors.grey,
        backgroundImage: 
            NetworkImage('https://picsum.photos/250?image=9'),
    );

    Widget _updateNotifications() {
        NotificationsController notificationsController = Get.find();
        return Obx(() =>
            ListView.builder(
                itemCount: notificationsController.notifications.length,
                itemBuilder: (BuildContext context, int index) {
                    return Container(
                        //height: 50,
                        child: Center(child: notificationsController.notifications[index]),
                    );
                }
            )
        );
    }
}

class NotificationsController extends GetxController {
    var _notifications = <InformationWidget>[].obs;
    List<InformationWidget> get notifications => _notifications.value;

    @override
    onInit() {
        super.onInit();
        _notifications.value = [
            InformationWidget("User Esteban","Commented","Pregunta 3278"),
            InformationWidget("User Camilo","Commented","Pregunta 1372"),
            InformationWidget("User David","Liked","Comentario 4327"),
            InformationWidget("User Estefinia","Liked","Comentario 7234"),
            InformationWidget("User Esteban","Commented","Pregunta 12"),
            InformationWidget("User Camilo","Liked","Comentario 17")
        ];
    }
}

class InformationWidget extends StatelessWidget {
    final emisor;
    final accion;
    final receptor;

    @override
    InformationWidget(this.emisor, this.accion, this.receptor);

    @override
    Widget build(BuildContext context) {
        return Card(
                child: Column(
                    children: [
                        Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                                color: colorCons.GREEN_BUTTON_COLOR,
                            ),
                            child: Text(
                                "Notificación",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                            ),
                        ),
                        Row(
                            children: [
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            "Emisor:",
                                            style: TextStyle(fontSize: 15),
                                        ),
                                    ),
                                ),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text("${this.emisor}"),
                                    )
                                ),
                            ],
                        ),
                        Row(
                            children: [
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                        "Accion:",
                                        style: TextStyle(fontSize: 15),
                                        ),
                                    ),
                                ),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text("${this.accion}"),
                                    ),
                                ),
                            ],
                        ),
                        Row(
                            children: [
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                        "Receptor:",
                                        style: TextStyle(fontSize: 15),
                                        ),
                                    ),
                                ),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text("${this.receptor}"),
                                    ),
                                ),
                            ],
                        ),
                    ],
                ),
        );
    }
}