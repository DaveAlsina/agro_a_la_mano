import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //Collection reference
  final CollectionReference agroCollection =
      FirebaseFirestore.instance.collection('users');

  //ESTO NO SE ESTA USANDO PARA EL LOGIN!!! ASI SE METE INFO EN FIREBASE
  Future updateUserData(
      String name, String email, String password, String picture) async {
    return await agroCollection.doc(uid).set({
      'name': name,
      "email": email,
      "password": password,
      "picture": picture,
    });
  }

  Future saveQuestion(
      String pregunta, String detalles, String tema, String image) async {
    return await agroCollection.doc(uid).set({
      'question': pregunta,
      "details": detalles,
      "theme": tema,
      "picture": image,
    });
  }
}
