import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_vrtual_flutter/helpers/firebase/validators.dart';
import 'package:loja_vrtual_flutter/models/user_manager/user.dart';
import 'package:loja_vrtual_flutter/models/user_manager/user_manager.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {

  // Recuperando os dados dos campos para salvar no Firebase
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  // Definindo a chave global para o validador
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),

      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: <Widget>[
                // Campo do E-mail
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'E-mail'
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email){
                    if(!emailValid(email)){
                      return 'E-mail inválido';
                    }
                    return null;
                   },
                ),
                const SizedBox(height: 16,),

                // Campo senha
                TextFormField(
                  controller: passController,
                  decoration: const InputDecoration(
                    hintText: 'Senha'
                  ),
                  autocorrect: false,
                  obscureText: true,
                  validator: (pass){
                    if(pass.isEmpty || pass.length < 6){
                      return 'Senha inválida';
                    }
                    return null;
                   },
                  ),

                // Botão esqueci a senha
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: (){

                    },
                    padding: EdgeInsets.zero,
                    child: const Text(
                      'Esqueci minha senha'
                    ),
                  ),
                ),
                const SizedBox(height: 16,),

                // Botão entrar
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: (){
                      // Verificar se a validação foi válida
                      if(formKey.currentState.validate()){
                        context.read<UserManager>().signIn(
                          User(
                            email: emailController.text,
                            password: passController.text
                          )
                        );
                      }

                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
