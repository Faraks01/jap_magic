import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/pages/CatalogPage/CatalogPage.dart';
import 'package:jap_magic/pages/PromoPage.dart';
import 'package:jap_magic/pages/UserPage/UserPage.dart';

import 'OrderPage/OrderPage.dart';

class MainPage extends StatelessWidget {
  static const routeName = '/main-page';

  final tabs = <Widget>[
    CatalogPage(),
    PromoPage(),
    PromoPage(),
    UserPage(),
    OrderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.list_bullet)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.placemark_fill)),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_stack_3d_up_fill)),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_badge_plus_fill)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart)),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return tabs[index];
      },
    );
  }
}
