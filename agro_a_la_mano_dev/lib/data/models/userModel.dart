import 'dart:core';
import 'package:get/get.dart';


class UserModel {

   int id;
   String name;
   String email;
   String picture;
   String password;

 UserModel({
   required this.id,
   required this.name,
   required this.email,
   required this.picture,
   required this.password,
  });


 /* getters */

  int getId() => id;
  String getName() => name;
  String getEmail() => email;
  String getPicture() => picture;
  String getPassword() => password;

  Map<String, dynamic> toMap() {
      return {
        'id': id,
        'name': name,
        'email': email,
        'picture': picture,
        'password': password,
      };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, picture : $picture, password: $password}';
  }

}
