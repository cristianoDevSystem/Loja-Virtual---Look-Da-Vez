import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_vrtual_flutter/helpers/validators/validators.dart';
import 'package:loja_vrtual_flutter/models/user_manager/user.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

  final TextEditingController passController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController ReplayPassController = TextEditingController();

  final TextEditingController textEditingController = TextEditingController();
  final MaskTextInputFormatter maskTextInputFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      // ignore: unnecessary_raw_strings
      filter: { "#": RegExp(r'[0-9]')}
  );


  final MaskTextInputFormatter maskDateFormatter = MaskTextInputFormatter(
      mask: '##/##/####');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();

  bool _passwordVisible = false;
  bool _repalayPassowrdVisible = false;

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {

    textEditingController.value = maskTextInputFormatter
        .updateMask("(##) #####-####");

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
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

                // Campo Nome
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person
                    ),
                    hintText: 'Nome Completo',
                    labelText: 'Nome*',
                  ),
                  validator: (name){
                    if(name.isEmpty){
                      // ignore: missing_return, missing_return
                      return '*Campo obrigatório';
                    }
                    else if(name.trim().split(' ').length <= 1){
                      return 'Preencha seu Nome Completo';
                    }
                    return null;
                  },
                  onSaved: (name) => user.name = name,
                ),
                const SizedBox(height: 16,),

                // Campo Telefone
                TextFormField(
                  controller: textEditingController,
                  inputFormatters: [maskTextInputFormatter],
                  autocorrect: false,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.phone
                    ),
                    hintText: 'Número de Telefone',
                    labelText: 'Telefone*',
                  ),
                  keyboardType: TextInputType.number,
                  maxLengthEnforced: false,
                  validator: (phone){
                    if(phone.isEmpty){
                      return '*Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (phone) => user.phone = phone,
                ),
                const SizedBox(height: 16,),

                // Campo Data de Nascimento
                TextFormField(
                  inputFormatters: [maskDateFormatter],
                  //controller: maskDateFormatter,
                  decoration: const InputDecoration(
                    icon: Icon(
                        Icons.date_range
                    ),
                    hintText: '00/00/0000',
                    labelText: 'Data de Nascimento*',
//                  suffix: Icon(
//                    Icons.date_range,
//                    color: Color.fromARGB(100, 0, 0, 0),
//                  ),
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (birthday){
                    if(birthday.isEmpty){
                      return '*Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (birthday) => user.birthday = birthday,
                ),
                const SizedBox(height: 16,),

                // Campo Email
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                    ),
                    hintText: 'Preencha o seu E-Mail',
                    labelText: 'E-Mail*',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email){
                    if(email.isEmpty){
                      return '*Campo obrigatório';
                    } else if(!emailValid(email)){
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                  onSaved: (email) => user.email = email,
                ),
                const SizedBox(height: 16,),

                // Campo senha
                TextFormField(
                  controller: passController,
                  decoration:  InputDecoration(
                      icon: const Icon(
                        Icons.lock
                      ),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        child: Icon(_passwordVisible == false ?
                          Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      hintText: 'Informe a senha',
                      labelText: 'Senha*'
                  ),
                  obscureText: !_passwordVisible,
                  validator: (pass){
                    if(pass.isEmpty){
                      return '*Campo obrigatório';
                    }
                    else if(pass.length < 6){
                      return 'Senha muito curta';
                    }
                    return null;
                  },
                  onSaved: (pass) => user.password = pass,
                  autocorrect: false,
                ),
                const SizedBox(height: 16,),

                // Campo Repetir a senha
                TextFormField(
                  controller: ReplayPassController,
                  decoration:  InputDecoration(
                      icon: const Icon(
                          Icons.lock
                      ),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            _repalayPassowrdVisible = !_repalayPassowrdVisible;
                          });
                        },
                        child: Icon(_repalayPassowrdVisible == false ?
                        Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      hintText: 'Repetir a Senha',
                      labelText: 'Senha*'
                  ),
                  obscureText: !_repalayPassowrdVisible,
                  validator: (pass){
                    if(pass.isEmpty){
                      return '*Campo obrigatório';
                    }
                    else if(pass.length < 6){
                      return 'Senha muito curta';
                    }
                    return null;
                  },
                  onSaved: (pass) => user.confirmPassword = pass,
                  autocorrect: false,
                ),
                const SizedBox(height: 16,),

                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    onPressed: (){
                      if(formKey.currentState.validate()){
                        formKey.currentState.save();

                        if(user.password != user.confirmPassword){
//                          scaffoldKey.currentState.showSnackBar(
//                              SnackBar(
//                                content: Text(
//                                    'Falhar ao entrar: $e'
//                                ),
//                              )
//                          );

                         showDialog(
                             context: context,
                           child: AlertDialog(
                             content: const Text(
                               'Senhas não coincidem! \n',
                               style: TextStyle(
                                 fontSize: 18,
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
                          return;
                        }
                      }

                    },
                    child: const Text(
                      'Criar Conta',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
