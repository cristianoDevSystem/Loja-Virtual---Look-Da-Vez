import 'package:flutter/cupertino.dart';

class PageManager {

  PageManager(this._pageController);

  PageController _pageController;

  int page = 0;

  // Metódo para trocar de página
  void setPage(int value){
    // Verificando a página atual
    if(value == page) return;
      page = value;
      _pageController.jumpToPage(value);
  }
}