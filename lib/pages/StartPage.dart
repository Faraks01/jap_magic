import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jap_magic/models/Brand.dart';
import 'package:jap_magic/models/Category.dart';
import 'package:jap_magic/models/Subcategory.dart';
import 'package:jap_magic/pages/MainPage.dart';
import 'package:jap_magic/providers/BrandsProvider.dart';
import 'package:jap_magic/providers/CategoriesProvider.dart';
import 'package:jap_magic/providers/FavoriteProductsProvider.dart';
import 'package:jap_magic/providers/SubcategoriesProvider.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  static const routeName = '/';

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brandsProvider = Provider.of<BrandsProvider>(context, listen: false);
    final subcategoriesProvider =
        Provider.of<SubcategoriesProvider>(context, listen: false);
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    final favoriteProductsProvider =
        Provider.of<FavoriteProductsProvider>(context, listen: false);

    return FutureBuilder(
      future: Future.wait<dynamic>([
        brandsProvider.fetchList(
            queryParams: {'limit': '1000'},
            offset: 0,
            triggerLoading: false,
            listApi: brandsProvider.fetchApi.makeRequest,
            modelJsonConstructor: (json) => Brand.fromJson(json)),
        categoriesProvider.fetchList(
            queryParams: {'limit': '1000'},
            offset: 0,
            triggerLoading: false,
            listApi: categoriesProvider.fetchApi.makeRequest,
            modelJsonConstructor: (json) => Category.fromJson(json)),
        subcategoriesProvider.fetchList(
            queryParams: {'limit': '1000'},
            offset: 0,
            triggerLoading: false,
            listApi: subcategoriesProvider.fetchApi.makeRequest,
            modelJsonConstructor: (json) => Subcategory.fromJson(json)),
        favoriteProductsProvider.getKeysFromDeviceStorage()
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.every((e) => e == 200)) {
          return MainPage();
        } else {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: CupertinoPageScaffold(
              child: Container(
                child: Center(
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (_, __) => Transform.scale(
                            scale: _controller.value * 0.2 + 0.8,
                            child: Image.asset(
                              'assets/images/japmagic_logo.png',
                            ),
                          )),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
