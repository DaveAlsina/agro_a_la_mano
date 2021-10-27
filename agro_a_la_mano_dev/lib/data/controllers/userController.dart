import 'package:get/get.dart';
import 'package:agro_a_la_mano_dev/data/models/userModel.dart';

class UserController extends GetxController{

  late UserModel usr;

  UserController(int id, String name, String email, String picture, String password){
    usr = UserModel(id: id, name: name, email: email, picture: picture, password: password).obs();
  }

  //getters

  get name => usr.name;
  get id => usr.id;
  get email => usr.email;

  String toString(){
    return usr.toString();
  }

  //setters
  void changeName(String newName){
    usr.name = newName;
    print(newName);
  }



}