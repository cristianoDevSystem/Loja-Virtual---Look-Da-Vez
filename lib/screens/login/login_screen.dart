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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            textColor: Colors.white,
            child: const Text(
              'CRIAR CONTA',
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),

      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            // O Widget Consumer é responsável por obsertar o estado do UserManager
            // é irá informar para todos caso o estado dele mude
            child: Consumer<UserManager>(

             // Tem que informar qual é o objeto que tem que observar
              builder: (_, userManager, child) {
             // No builder tem que passar o contexto, que nesse não importa, irá
             // receber o objeto userManager, é irá paassar um child que não irá
             // ser utilizado, que é uma forma de não rebuidar algum widget
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    // Campo do E-mail
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
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
                      enabled: !userManager.loading,
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
                      obscureText: !_showPassword,
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

                    const SizedBox(height: 16,),

                    // Botão entrar
                    child,

                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: userManager.loading ? null : (){
                          // Verificar se a validação foi válida
                          if(formKey.currentState.validate()){
                            userManager.signIn(
                                user: User(
                                  email: emailController.text,
                                  password: passController.text,
                                ),
                                onFail: (e){
//                                  scaffoldKey.currentState.showSnackBar(
//                                      SnackBar(
//                                        content: Text(
//                                          'Falhar ao entrar: $e',
//                                          style: TextStyle(
//                                              color: Colors.black
//                                          ),),
//                                        backgroundColor: Colors.yellow,
//                                      )
//                                  );

                                  showDialog(
                                      context: context,
                                    child: AlertDialog(
                                      content:  Text(
                                        'Falha ao Entrar!! \n$e',
                                        style: const TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Fechar',
                                          ),
                                        )
                                      ],
                                    )
                                  );
                                },

                                onSuccess: () {
                                  // TODO: FECHAR A TELA DE LOGIN
                                }
                            );
                          }
                        },
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).primaryColor
                            .withAlpha(100),
                        textColor: Colors.white,
                        child: userManager.loading ?
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                            Colors.white
                          ),
                        ) :
                        const Text(
                          'Entrar',
                          style: TextStyle(
                              fontSize: 18
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              // Botão entrar
              child: Align(
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
            ),
          ),
        ),
      ),
    );
  }
}
