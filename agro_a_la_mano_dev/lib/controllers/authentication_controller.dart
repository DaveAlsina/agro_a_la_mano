import 'package:agro_a_la_mano_dev/data/local_preferences.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  LocalPreferences lp = LocalPreferences();

  var _logged = false.obs;

  bool get logged => _logged.value;

  void setLogged(bool l) {
    _logged.value = l;
    update();
  }

  AuthenticationController() {
    init();
  }

  void init() async {
    _logged.value = await lp.retrieveData<bool>("logged") ?? false;
    setLogged(false);
  }

  Future<bool> registerUser(String name, String email, String pass) async {
    await lp.storeData<String>("name", name);
    await lp.storeData<String>("password", pass);
    await lp.storeData<String>("email", email);
    return Future.value(true);
  }

  Future<bool> login(email, password) async {
    String emailT = await lp.retrieveData<String>("email") ?? "";
    String passwordT = await lp.retrieveData<String>("password") ?? "";

    if (emailT == email && passwordT == password) {
      await lp.storeData<bool>("logged", true);
      setLogged(true);
    } else {
      await lp.storeData<bool>("logged", false);
      setLogged(false);
    }
    return Future.value(_logged.value);
  }

  Future<bool> signup(name, email, password) async {
    String emailT = await lp.retrieveData<String>("email") ?? "";
    if (emailT != name) {
      await registerUser(name, email, password);
      return Future.value(true);
    }

    return Future.value(false);
  }

  Future<bool> logout() async {
    await lp.storeData<bool>("logged", false);
    setLogged(false);
    return Future.value(true);
  }
}
