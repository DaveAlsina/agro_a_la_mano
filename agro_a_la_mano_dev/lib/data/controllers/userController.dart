import 'package:get/get.dart';
import 'package:agro_a_la_mano_dev/data/models/userModel.dart';

class DatabaseConnection {

  bool _registered = true;
  bool _logged = true;

  /* setters */

  bool changeUserName(String name) {

    return true;
  }

  bool changeUserEmail(String email) {

    return true;
  }

  bool updateUserInfo(UserModel usr) {

    return true;
  }

  /* getters */

  List<String> getUserDetails(String email, String password){

    //name, picture,
    return ['Chontaduro'];
  }

  /* sort of initializer */

  bool registerUser(String name, String email, String password){

    return _registered;
  }

  /* checkers */

  bool checkLogin(String email, String password){

    return _logged;
  }



}

/*

	Atributos:	-> dataBaseConnection, Conecta con la base de datos para hacerle peticiones.
              -> usr, lista de usuarios (que el la práctica solo tiene un usuario, usada
                      para manejar la información relativa al usuario).


	Descripción: 	(Esta clase está pensada para usarse para controlar los movimientos de información
	              relativos al usuario).

	(para cada uno de los métodos que se implementen en la clase se aplica el template
	de comentado que se dejó más arriba).

*/

class UserController extends GetxController{

  late DatabaseConnection dataBaseConnection;
  late RxList<UserModel> usr;

  @override
  onInit(){

      dataBaseConnection = DatabaseConnection();
      usr = <UserModel>[].obs;
  }

  /* getters */

  String get name => usr.isEmpty? '' : usr[0].name;
  String get email => usr.isEmpty? '' : usr[0].email;
  String get password => usr.isEmpty? '' : usr[0].password;

  /* setters */

  set name (String name) => usr[0].name = name;
  set email (String email) => usr[0].email = email;

  /* updaters */

  Future<bool> updateUserInfo() async {

    bool updateResult = await dataBaseConnection.updateUserInfo(usr[0]);
    return updateResult;
  }


    /*
      Input: String name -> nombre del usuario
             String email -> correo del usuario
             String password -> contraseña del usuario

      Output: bool (true -> si se pudo añadir a la base de datos
                    false de lo contrario)
   */

    bool addNewUser(String name, String email, String password){

      bool registerResult = dataBaseConnection.registerUser(name, email, password);

      if (registerResult) {

        var localUser = UserModel();
        localUser.name = name;
        localUser.email = email;
        localUser.password = password;

        usr.clear();
        usr.add(localUser);

        return true;
      }

      return false;

    }

    /*
      Input: String email -> correo del usuario
             String password -> contraseña del usuario

      Output: bool (true -> si se pudo loggear con esas credenciales
                    false de lo contrario)
   */

    bool userLogin(String email, String password){

      bool logged = dataBaseConnection.checkLogin(email, password);

      if (logged){

        var localUser = UserModel();
        localUser.email = email;
        localUser.password = password;
        List<String> extra_info = dataBaseConnection.getUserDetails(email, password);
        localUser.name = extra_info[0];

        usr.clear();          //borra el anterior registro de usuario
        usr.add(localUser);   //añade el nuevo registro de usuario

        return true;
      }

      return false;
    }

    String toString(){
      if(usr.isEmpty){
        return '';
      }

      return usr[0].toString();
    }
}
