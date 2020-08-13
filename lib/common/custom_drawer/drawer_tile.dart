import 'package:flutter/material.dart';
import 'package:loja_vrtual_flutter/models/page_manager/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {

  // Declarando o construdor do parâmetro do ícone
  const DrawerTile({this.iconData, this.title, this.page});

  // Passando  por parâmetro
  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    // Obtendo a acesso a página atual
    final int curPage = context.watch<PageManager>().page;
    final Color primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: (){
        context.read<PageManager>().setPage(page);

      },

      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: curPage == page ? primaryColor : Colors.grey[700],
              ),
            ),

            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: curPage == page ? primaryColor : Colors.grey[700],
              ),
            )
          ],
        ),
      ),
    );
  }
}
