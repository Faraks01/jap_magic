import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jap_magic/pages/BrandPage.dart';
import 'package:jap_magic/pages/CategoryPage.dart';
import 'package:jap_magic/pages/DeliveryInfoPage.dart';
import 'package:jap_magic/pages/FeedbacksPage.dart';
import 'package:jap_magic/pages/MainPage.dart';
import 'package:jap_magic/pages/ProductPage.dart';
import 'package:jap_magic/pages/StartPage.dart';
import 'package:jap_magic/providers/BrandsProvider.dart';
import 'package:jap_magic/providers/CategoriesProvider.dart';
import 'package:jap_magic/providers/FavoriteProductsProvider.dart';
import 'package:jap_magic/providers/OrderProvider.dart';
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
        ChangeNotifierProvider<OrderProvider>(
          create: (_) => OrderProvider(),
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
                navLargeTitleTextStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w700),
                navActionTextStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w700),
                navTitleTextStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w700),
                textStyle: TextStyle(
                  fontFamily: 'OpenSans',
                )),
            primaryColor: Colors.pink[400],
            barBackgroundColor: Colors.black,
            scaffoldBackgroundColor: Colors.grey[200]),
        home: StartPage(),
        routes: {
          MainPage.routeName: (_) => MainPage(),
          BrandPage.routeName: (ctx) {
            final BrandPageRouteArguments routeParams =
                ModalRoute.of(ctx).settings.arguments;

            final brandsProvider =
                Provider.of<BrandsProvider>(ctx, listen: false);

            return BrandPage(brand: brandsProvider.map[routeParams.id]);
          },
          CategoryPage.routeName: (ctx) {
            final CategoryPageRouteArguments routeParams =
                ModalRoute.of(ctx).settings.arguments;

            final categoriesProvider =
                Provider.of<CategoriesProvider>(ctx, listen: false);

            return CategoryPage(
                category: categoriesProvider.map[routeParams.id]);
          },
          ProductPage.routeName: (ctx) {
            final ProductPageRouteArguments routeParams =
                ModalRoute.of(ctx).settings.arguments;

            final product = Provider.of<ProductsProvider>(ctx, listen: false)
                .map[routeParams.id];

            return ProductPage(
              product: product,
              id: product == null ? routeParams.id : null,
            );
          },
          DeliveryInfoPage.routeName: (ctx) => DeliveryInfoPage(),
          FeedbacksPage.routeName: (ctx) {
            final _routeParams = ModalRoute.of(ctx).settings.arguments;
            assert(_routeParams is FeedbacksPageRouteArguments);

            final FeedbacksPageRouteArguments routeParams = _routeParams;

            return FeedbacksPage(product: routeParams.product);
          },
        },
      ),
    );
  }
}
