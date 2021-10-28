import 'package:agro_a_la_mano_dev/data/models/userModel.dart';
import 'package:flutter/cupertino.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TestUserModel());
}


class  TestUserModel extends  StatelessWidget{

  UserModel usr1 = UserModel();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(usr1.toString()),
    );
  }

}






