import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/models/Product.dart';
import 'package:jap_magic/pages/ProductPage.dart';
import 'package:jap_magic/providers/BrandsProvider.dart';
import 'package:jap_magic/themes.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context, rootNavigator: true);

    final brand = Provider.of<BrandsProvider>(context, listen: false).map[product.brand];

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 30,
      onPressed: () {
        nav.pushNamed(ProductPage.routeName,
            arguments: ProductPageRouteArguments(id: product.id));
      },
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 120,
                  ),
                  child: Image.network(product.image, fit: BoxFit.fill),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(brand.name, style: AppTextTheme.mdTitle),
                    const SizedBox(height: 6),
                    Text(product.name, style: AppTextTheme.mdText),
                    const SizedBox(height: 3),
                    ...product.propertiesPairs
                        .map((e) => Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text.rich(TextSpan(
                        text: "${e[0]}: ",
                        style: AppTextTheme.xsTitle,
                        children: [
                          TextSpan(
                              text: e[1],
                              style: AppTextTheme.xsText.merge(
                                  TextStyle(
                                      color: Colors.grey[600])))
                        ],
                      )),
                    ))
                        .toList(),
                    const SizedBox(height: 6),
                    Text('${product.intPrice} ₽',
                        style: AppTextTheme.lgTitle),
                    const SizedBox(height: 6),
                    Text('# ${product.barcode}',
                        style: AppTextTheme.smText),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
