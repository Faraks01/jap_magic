import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jap_magic/pages/MainPage.dart';
import 'package:jap_magic/providers/BrandsProvider.dart';
import 'package:jap_magic/providers/CategoriesProvider.dart';
import 'package:jap_magic/providers/FavoriteProductsProvider.dart';
import 'package:jap_magic/providers/ProductLinesProvider.dart';
import 'package:jap_magic/providers/ProductsProvider.dart';
import 'package:jap_magic/providers/SubcategoriesProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BrandsProvider>(
          create: (_) => BrandsProvider(),
        ),
        ChangeNotifierProvider<CategoriesProvider>(
          create: (_) => CategoriesProvider(),
        ),
        ChangeNotifierProvider<ProductLinesProvider>(
          create: (_) => ProductLinesProvider(),
        ),
        ChangeNotifierProvider<ProductsProvider>(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider<SubcategoriesProvider>(
          create: (_) => SubcategoriesProvider(),
        ),
        ChangeNotifierProvider<FavoriteProductsProvider>(
          create: (_) => FavoriteProductsProvider(),
        ),
      ],
      child: CupertinoApp(
        title: 'Jap Magic',
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [
          const Locale('en', 'US'),
          const Locale('en', 'GB'),
        ],
        theme: CupertinoThemeData(
            textTheme: const CupertinoTextThemeData(
              navTitleTextStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w700),
            ),
            primaryColor: Colors.pink[400],
            barBackgroundColor: Colors.black,
            scaffoldBackgroundColor: Colors.grey[200]),
        home: MainPage(),
      ),
    );
  }
}
