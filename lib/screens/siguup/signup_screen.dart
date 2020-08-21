import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {

    final TextEditingController passController = TextEditingController();
    // ignore: non_constant_identifier_names
    final TextEditingController ReplayPassController = TextEditingController();

    final textEditingController = TextEditingController();
    final maskTextInputFormatter = MaskTextInputFormatter(mask: '(##) #####-####',
      // ignore: unnecessary_raw_strings
      filter: { "#": RegExp(r'[0-9]')}
    );
    final maskDateFormatter = MaskTextInputFormatter(mask: '##/##/####');

    textEditingController.value = maskTextInputFormatter.updateMask("(##) #####-####");

    bool _password = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
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
                  labelText: 'Telefone',
                ),
                keyboardType: TextInputType.number,
                maxLengthEnforced: false,
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
                  labelText: 'Data de Nascimento',
//                  suffix: Icon(
//                    Icons.date_range,
//                    color: Color.fromARGB(100, 0, 0, 0),
//                  ),
                ),
                onTap: (){

                },
                keyboardType: TextInputType.datetime,
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
                          _password = !_password;
                        });
                      },
                      child: Icon(_password == false ?
                        Icons.visibility_off : Icons.visibility,
                      color: const Color.fromARGB(100, 0, 0, 0),
                      ),
                    ),
                    hintText: 'Informe a senha',
                    labelText: 'Senha'
                ),
                obscureText: !_password,
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
                          _password = !_password;
                        });
                      },
                      child: Icon(_password == false ?
                      Icons.visibility_off : Icons.visibility,
                        color: const Color.fromARGB(100, 0, 0, 0),
                      ),
                    ),
                    hintText: 'Repetir a Senha',
                    labelText: 'Senha'
                ),
                obscureText: !_password,
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
    );
  }
}
