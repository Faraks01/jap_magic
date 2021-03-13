import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/models/Product.dart';
import 'package:jap_magic/pages/ProductPage.dart';
import 'package:jap_magic/providers/BrandsProvider.dart';
import 'package:jap_magic/providers/OrderProvider.dart';
import 'package:jap_magic/themes.dart';
import 'package:jap_magic/widgets/ProductFavoriteButton.dart';
import 'package:provider/provider.dart';

class ProductGridCard extends StatelessWidget {
  final Product product;

  const ProductGridCard({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context, listen: false);

    final brandName = Provider.of<BrandsProvider>(context, listen: false)
        .map[product.brand]
        .name;

    return CupertinoButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
            ProductPage.routeName,
            arguments: ProductPageRouteArguments(id: product.id));
      },
      padding: EdgeInsets.zero,
      child: Card(
        elevation: 2,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: ProductFavoriteButton(productId: product.id),
                    )
                  ],
                ),
              )),
              ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      brandName,
                      textAlign: TextAlign.left,
                      style: AppTextTheme.smTitle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextTheme.smText
                          .merge(TextStyle(color: Colors.grey[700])),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${product.intPrice} ₽',
                            style: AppTextTheme.smTitle),
                        Selector<OrderProvider, bool>(
                          selector: (_, p) => p.map.containsKey(product.id),
                          builder: (context, inCart, child) => IconButton(
                              icon: Icon(
                                  inCart
                                      ? CupertinoIcons.checkmark_circle
                                      : CupertinoIcons.cart,
                                  color: inCart ? Colors.green : null),
                              iconSize: 30,
                              onPressed: inCart ? null : () {
                                if (orderPvd.recentlyViewedProducts.contains(product)) {
                                  orderPvd.recentlyViewedProducts.remove(product);
                                }

                                orderPvd.addListItem(product);
                                orderPvd.notifyListeners();
                              }),
                        )
                      ],
                    )
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
