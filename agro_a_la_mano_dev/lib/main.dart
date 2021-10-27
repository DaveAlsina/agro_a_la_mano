import 'package:agro_a_la_mano_dev/domain/controllers/authentication_controller.dart';
import 'package:agro_a_la_mano_dev/ui/home_page.dart';
import 'package:agro_a_la_mano_dev/ui/login_page.dart';
import 'package:agro_a_la_mano_dev/ui/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:asse as Icons_constants;

void main() {
  Get.put(AuthenticationController());
  runApp(HomePage());
}
