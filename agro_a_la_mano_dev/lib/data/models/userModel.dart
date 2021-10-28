import 'dart:core';


class UserModel {

  //int id;
  //String picture;
  String name = '';
  String email = '';
  String password = '';


  /* getters */

  //int getId() => id;
  //String getPicture() => picture;
  String getName() => name;
  String getEmail() => email;
  String getPassword() => password;

  /* setters */

  bool addInfo(String name, String email, String password){

    this.name = name;
    this.email = email;
    this.password = password;

    return true;
  }


  Map<String, dynamic> toMap() {
      return {
        //'id': id,
        //'picture': picture,
        'name': name,
        'email': email,
        'password': password,
      };
  }

  @override
  String toString() {
      //return 'User{id: $id, name: $name, email: $email, picture : $picture, password: $password}';
      return 'User{name: $name, email: $email, password: $password}';
  }

}
