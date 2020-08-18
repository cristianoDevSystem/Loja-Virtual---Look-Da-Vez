import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_vrtual_flutter/helpers/validators/validators.dart';
import 'package:loja_vrtual_flutter/models/user_manager/user.dart';
import 'package:loja_vrtual_flutter/models/user_manager/user_manager.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {

  // Recuperando os dados dos campos para salvar no Firebase
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _showPassword = false;

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
                    icon: Icon(
                      Icons.email,
                      color: Color.fromARGB(100, 0, 0, 0),
                    ),
                    labelText: 'E-Mail',
                    hintText: 'Informe seu E-mail'
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  style: const TextStyle(
                      fontSize: 18
                  ),
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
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: const Color.fromARGB(100, 0, 0, 0),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: (){
                        setState((){
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(_showPassword == false ?
                        Icons.visibility_off
                        : Icons.visibility,
                      color: const Color.fromARGB(100, 0, 0, 0),
                      ),
                    ),
                    labelText: 'Senha',
                    hintText: 'Digite a sua Senha'
                  ),
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  obscureText: _showPassword,
                  autocorrect: false,
                  style: const TextStyle(
                    fontSize: 18
                  ),

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
                          user: User(
                            email: emailController.text,
                            password: passController.text,
                          ),
                          onFail: (e){
                            print(e);
                          },

                          onSuccess: () {
                            print('Sucesso');
                          }
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
