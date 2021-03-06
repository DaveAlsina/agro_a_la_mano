//paquetes de las páginas implementadas
import 'package:agro_a_la_mano_dev/controllers/files_controller.dart';
import 'package:agro_a_la_mano_dev/pages/comentarios_page.dart';
import 'package:agro_a_la_mano_dev/pages/feed_page.dart';
import 'package:agro_a_la_mano_dev/pages/home_page.dart';
import 'package:agro_a_la_mano_dev/pages/login_page.dart';
import 'package:agro_a_la_mano_dev/pages/post_page.dart';
import 'package:agro_a_la_mano_dev/pages/questionhist_page.dart';
import 'package:agro_a_la_mano_dev/pages/profile_page.dart';
import 'package:agro_a_la_mano_dev/pages/questionask_page.dart';
import 'package:agro_a_la_mano_dev/pages/signup_page.dart';

// constantes de estilo
import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
    as Color_constants;
import 'package:firebase_core/firebase_core.dart';
import 'assets/icons.dart' as Icons_constants;

//Controladores
import 'package:agro_a_la_mano_dev/controllers/messages_controller.dart';
import 'package:agro_a_la_mano_dev/controllers/authentication_controller.dart';

//libs estándar
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthenticationController auth = Get.put(AuthenticationController());
  await Get.put(HistoryController());
  await Get.put(NotificationsController());

  runApp(GetMaterialApp(
    home: Obx(() => auth.logged? MaterialApp(home: HomePage()) : LoginPage()),
    getPages: [
      GetPage(
        name: '/SignUpPage',
        page: () => SignupPage(),
        transition: Transition.fade,
      ),
      GetPage(
        name: '/LoginPage',
        page: () => LoginPage(),
        transition: Transition.fade,
      ),
      GetPage(
        name: '/Home',
        page: () => HomePage(),
        transition: Transition.leftToRight,
      ),
      GetPage(
        name: '/QuestionPage',
        page: () => QuestionPage(),
        transition: Transition.leftToRight,
      ),
      GetPage(
          name: '/QuestionHistoryPage',
          page: () => QuestionHistoryPage(),
          transition: Transition.leftToRight,
          children: [
            GetPage(
              name: '/CommentPage',
              page: () => ComentariosPage(),
            )
          ]),
      GetPage(
        name: '/PostPage',
        page: () => Post(),
        transition: Transition.leftToRight,
      ),
      GetPage(
        name: '/ProfilePage',
        page: () => ProfilePage(),
        transition: Transition.leftToRight,
      ),
      GetPage(
          name: '/FeedPage',
          page: () => FeedPage(),
          transition: Transition.cupertino
      )
    ],
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(
                color: Color_constants.BLUE_LETTERS_COLOR,
                fontFamily: 'Noto Sans',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icons_constants.GO_DOWN_ICON,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
