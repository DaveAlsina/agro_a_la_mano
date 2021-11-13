import 'package:agro_a_la_mano_dev/services/auth.dart';
import 'package:agro_a_la_mano_dev/services/database.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  // LocalPreferences lp = LocalPreferences();
  AuthService _auth = AuthService();
  var _logged = false.obs;

  // DatabaseService _database = DatabaseService(uid: _uid.value);

  bool get logged => _logged.value;

  void setLogged(bool l) {
    _logged.value = l;
    update();
  }

  AuthenticationController() {
    init();
  }

  void init() async {
    // _logged.value = await lp.retrieveData<bool>("logged") ?? false;
    setLogged(false);
  }

  Future<bool> login(email, password) async {
    dynamic response = await _auth.signUpEmailAndPass(email, password);
    if (response == null) {
      setLogged(false);
      return false;
    } else {
      setLogged(true);
      print(response);
      return true;
    }
  }

  Future<bool> signup(name, email, password) async {
    dynamic response = await _auth.registerEmailAndPass(email, password, name);
    if (response == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> logout() async {
    // await lp.storeData<bool>("logged", false);
    dynamic response = await _auth.signOut();
    print(response);
    setLogged(false);
    return true;
  }

  // Future<bool> saveUser(String email, String name, String picture) async {
  //   dynamic response = await _database.saveUserData(name, email, picture);
  //   if (response == null) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
}
