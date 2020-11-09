import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/pages/CatalogPage.dart';
import 'package:jap_magic/pages/PromoPage.dart';

class MainPage extends StatelessWidget {
  final tabs = <Widget>[
    CatalogPage(),
    PromoPage(),
    PromoPage(),
    PromoPage(),
    PromoPage(),
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
        return CupertinoTabView(
          builder: (BuildContext context) {
            return tabs[index];
            // return CupertinoPageScaffold(
            //   navigationBar: CupertinoNavigationBar(
            //     middle: Text('JAPMAGIC'),
            //   ),
            //   child: Center(
            //     child: CupertinoButton(
            //       child: const Text('Next page'),
            //       onPressed: () {
            //         Navigator.of(context).push(
            //           CupertinoPageRoute<void>(
            //             builder: (BuildContext context) {
            //               return CupertinoPageScaffold(
            //                 navigationBar: CupertinoNavigationBar(
            //                   middle: Text('Page 2 of tab $index'),
            //                 ),
            //                 child: Center(
            //                   child: CupertinoButton(
            //                     child: const Text('Back'),
            //                     onPressed: () {
            //                       Navigator.of(context).pop();
            //                     },
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // );
          },
        );
      },
    );
  }
}
