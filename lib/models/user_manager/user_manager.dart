import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:loja_vrtual_flutter/helpers/firebase/firebase_errors.dart';
import 'package:loja_vrtual_flutter/models/user_manager/user.dart';

class UserManager {

  final FirebaseAuth auth = FirebaseAuth.instance;

  //Função de signIn - Login
  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password

      );

      onSuccess();

    } on PlatformException catch (e){
      onFail(getErrorString(e.code));
    }
  }

}