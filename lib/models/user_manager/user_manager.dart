import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_vrtual_flutter/helpers/firebase/firebase_errors.dart';
import 'package:loja_vrtual_flutter/models/user_manager/user.dart';

class UserManager extends ChangeNotifier {

  // Recebendo o usuário logado
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  // Usuário atual
  FirebaseUser user;

  bool _loading = false;
  bool get loading => _loading;

  //Função de signIn - Login
  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      this.user = result.user;


      onSuccess();
      // Retornando o erro recebido
    } on PlatformException catch (e){
      onFail(getErrorString(e.code));
    }

    loading = false;

  }

  // Metodo para verificar o estado do login
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  // Retornando o usuário que estar logado
  Future<void> _loadCurrentUser() async {
    final FirebaseUser currentUser = await auth.currentUser();
    // Verificando se o usuário é diferente de nulo
    if(currentUser !=null){
      // Salvando o usuário atual
      user = currentUser;
      print(user.uid);
    }
    notifyListeners();
  }

}