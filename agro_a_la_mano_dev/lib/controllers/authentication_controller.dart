import 'package:agro_a_la_mano_dev/services/auth.dart';
import 'package:agro_a_la_mano_dev/services/database.dart';
import 'package:get/get.dart';


import 'files_controller.dart';

class AuthenticationController extends GetxController {
  // LocalPreferences lp = LocalPreferences();
  AuthService _auth = AuthService();

  get uid => _auth.uid;

  //nuevo
  late DatabaseService _fireStoreDatabase;

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
    // _logged.value = await lp.retrieveData<bool>("logged") ?? false;
    setLogged(false);
  }

  // Future<bool> registerUser(String name, String email, String pass) async {
  //   // await lp.storeData<String>("name", name);
  //   // await lp.storeData<String>("password", pass);
  //   // await lp.storeData<String>("email", email);

  //   await DatabaseService(uid: email).updateUserData(name, email, pass, '');
  //   return Future.value(true);
  // }

  // Future<bool> login(email, password) async {
  // String emailT = await lp.retrieveData<String>("email") ?? "";
  // String passwordT = await lp.retrieveData<String>("password") ?? "";

  // if (emailT == email && passwordT == password) {
  // await lp.storeData<bool>("logged", true);
  // setLogged(true);
  // } else {
  // await lp.storeData<bool>("logged", false);
  // setLogged(false);
  // }
  // return Future.value(_logged.value);
  // }
  Future<bool> login(email, password) async {
    dynamic response = await _auth.signUpEmailAndPass(email, password);

    if (response == null) {
      setLogged(false);
      return false;

    } else {


      _fireStoreDatabase = DatabaseService(uid: response.uid!);
      setLogged(true);

      // en el momento en que se logea o hace signup
      // se habilita el controlador de archivos
      await Get.put(FileController());

      return true;
    }
  }

  Future<bool> signup(name, email, password) async {
    dynamic response = await _auth.registerEmailAndPass(email, password);

    if (response == null) {
      return false;
    } else {

      _fireStoreDatabase = DatabaseService(uid: response.uid!);
      _fireStoreDatabase.updateUserData(name, email, '');

      // en el momento en que se logea o hace signup
      // se habilita el controlador de archivos
      await Get.put(FileController());
      return true;
    }
    // String emailT = await lp.retrieveData<String>("email") ?? "";
    // if (emailT != name) {
    // await registerUser(name, email, password);
    // return Future.value(true);
  }

  // return Future.value(false);
  // }

  Future<bool> logout() async {
    // await lp.storeData<bool>("logged", false);
    dynamic response = await _auth.signOut();
    print(response);
    setLogged(false);
    return true;
  }
}
