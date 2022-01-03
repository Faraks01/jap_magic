import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/models/Product.dart';
import 'package:jap_magic/providers/FavoriteProductsProvider.dart';
import 'package:jap_magic/providers/ProductsProvider.dart';
import 'package:jap_magic/widgets/ProductCard.dart';
import 'package:jap_magic/widgets/ProductGridCard.dart';
import 'package:jap_magic/widgets/StoreList.dart';
import 'package:provider/provider.dart';

class FavoriteProductsPage extends StatelessWidget {
  static const routeName = "/favorite-products-page";
  final String navTitle = "Избранное";

  const FavoriteProductsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProductsPvd =
        Provider.of<FavoriteProductsProvider>(context, listen: false);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(navTitle, style: TextStyle(color: Colors.white)),
      ),
      child: StoreList<ProductsProvider, Product>(
        limit: 10,
        itemAspectRatio: 0.6,
        queryParams: {'id__in': favoriteProductsPvd.productIds.join(",")},
        modelJsonConstructor: (json) => Product.fromJson(json),
        renderListItem: (item, key) => ProductGridCard(product: item, key: key),
      ),
    );
  }
}
