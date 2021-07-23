import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/providers/OrderProvider.dart';
import 'package:jap_magic/themes.dart';
import 'package:jap_magic/widgets/ProductCard.dart';
import 'package:provider/provider.dart';

class RecentlyViewedProductsPage extends StatelessWidget {
  static const routeName = "/recently-viewed-products-page";
  final String navTitle = "Просмотренные товары";

  const RecentlyViewedProductsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context, listen: false);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(navTitle, style: TextStyle(color: Colors.white)),
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Selector<OrderProvider, int>(
          selector: (_, p) => p.recentlyViewedProducts.length,
          builder: (context, recentlyViewedProductsLength, child) {
            print(recentlyViewedProductsLength);
            if (recentlyViewedProductsLength == 0) {
              return Padding(
                  padding: const EdgeInsets.only(top: 8),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text("Вы еще не просмотрели ни одного товара!", style: AppTextTheme.lgText),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: recentlyViewedProductsLength,
                itemBuilder: (context, index) {
                  final product = orderPvd.recentlyViewedProducts[index];
                  final isLastItem = index == recentlyViewedProductsLength - 1;

                  return Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, isLastItem ? 8 : 0),
                    child: SizedBox(
                      width: 160,
                      child: ProductCard(
                          product: product, key: Key('${product.id}_recent')),
                    ),
                  );
                },
              );
            }
          }
        ),
      ),
    );
  }
}
