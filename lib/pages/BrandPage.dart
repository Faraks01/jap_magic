import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:jap_magic/models/Brand.dart';
import 'package:jap_magic/models/Product.dart';
import 'package:jap_magic/widgets/ProductGridCard.dart';
import 'package:jap_magic/providers/ProductsProvider.dart';
import 'package:jap_magic/widgets/StoreList.dart';

class BrandPageRouteArguments {
  final int id;

  BrandPageRouteArguments({
    @required this.id,
  });
}

class BrandPage extends StatelessWidget {
  static const routeName = '/brand-page';

  final Brand brand;

  BrandPage({this.brand});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(brand.name, style: TextStyle(color: Colors.white)),
      ),
      child: StoreList<ProductsProvider, Product>(
        limit: 10,
        itemAspectRatio: 0.6,
        queryParams: {'brand': '${brand.id}'},
        headerWidgets: [
          Hero(
            tag: 'brand_picture_${brand.id}',
            child: Image.network(
              brand.image,
              height: 200,
              fit: BoxFit.contain,
            ),
          )
        ],
        modelJsonConstructor: (json) => Product.fromJson(json),
        renderListItem: (item, key) => ProductGridCard(product: item, key: key),
      ),
    );
  }
}
