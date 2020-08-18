import 'package:flutter/material.dart';
import 'package:loja_vrtual_flutter/common/custom_drawer/custom_drawer.dart';
import 'package:loja_vrtual_flutter/models/page_manager/page_manager.dart';
import 'package:loja_vrtual_flutter/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {

  // Configurando um controlador da página
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {



    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        // Definindo o controlador
        controller: pageController,

        // Impedindo que possa arrasatar a página para trocar-lá atráves de gesto
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          // Página Inicial
          LoginScreen(),

          // Página Produtos
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Produtos'),
            ),
          ),

          // Página Meus Pedidos
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Meus Pedidos'),
            ),
          ),

          // Página Lojas
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Lojas'),
            ),
          ),

        ],
      ),
    );

  }
}
