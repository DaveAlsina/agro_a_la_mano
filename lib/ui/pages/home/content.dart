import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:f_authentication_template/domain/controllers/authentication_controller.dart';
import 'home_page.dart';
import 'profile_page.dart';

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  int _selectedIndex = 0;

  AuthenticationController controller = Get.find<AuthenticationController>();

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if(index == 2) {controller.logout();}
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              label: 'Historial',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.backspace_sharp),
              label: 'Log out',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ));
  }
}
