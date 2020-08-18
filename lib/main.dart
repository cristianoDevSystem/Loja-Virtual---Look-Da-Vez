import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_vrtual_flutter/models/user_manager/user_manager.dart';
import 'package:loja_vrtual_flutter/screens/base/base_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => UserManager(),

      child: MaterialApp(
        title: 'Look Da Vez',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryTextTheme: const TextTheme(
              headline6: TextStyle(
                  color: Colors.white
              )
          ),

          //primarySwatch: Colors.red,

          // Definindo a cor primária
          primaryColor: const Color.fromARGB(255, 250, 128, 114),

          // Definir a cor background o copor do app
          scaffoldBackgroundColor: const Color.fromARGB(255, 250, 128, 128),
          // Retira a linha de elevação de divisão do app
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.white
            )
          ),

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BaseScreen(),
      ),
    );
  }
}

