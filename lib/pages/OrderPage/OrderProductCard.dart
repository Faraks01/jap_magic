import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jap_magic/models/Product.dart';
import 'package:jap_magic/network/Session.dart';
import 'package:jap_magic/pages/ProductPage.dart';
import 'package:jap_magic/providers/BrandsProvider.dart';
import 'package:jap_magic/providers/OrderProvider.dart';
import 'package:jap_magic/themes.dart';
import 'package:provider/provider.dart';

class OrderProductCard extends StatelessWidget {
  final Product product;
  final Key key;
  final SlidableController slidableController;
  final bool firstItemInList;

  OrderProductCard(this.product,
      {@required this.key,
      this.slidableController,
      this.firstItemInList = false})
      : assert(product != null),
        assert(key != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context, listen: false);

    final nav = Navigator.of(context, rootNavigator: true);

    final brand =
        Provider.of<BrandsProvider>(context, listen: false).map[product.brand];

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Slidable(
        key: key,
        controller: slidableController,
        actionPane: SlidableBehindActionPane(),
        actionExtentRatio: 0.25,
        child: Builder(
          builder: (context) {
            if (firstItemInList && !Session().orderPageAnimations) {
              final slidableController = Slidable.of(context);

              Future.delayed(Duration.zero, () {
                slidableController.open(actionType: SlideActionType.secondary);

                Future.delayed(Duration(milliseconds: 500), () {
                  slidableController.close();
                  Session().orderPageAnimations = true;
                });
              });
            }

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
          },
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            color: Colors.red[800],
            iconWidget: Icon(CupertinoIcons.multiply_circle_fill,
                size: 46, color: Colors.white),
            onTap: () {
              orderPvd.removeListItem(product.id, notify: true);
            },
          ),
        ],
      ),
    );
  }
}
