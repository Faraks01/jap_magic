import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jap_magic/models/Product.dart';
import 'package:jap_magic/network/Session.dart';
import 'package:jap_magic/providers/OrderProvider.dart';
import 'package:jap_magic/widgets/ProductCard.dart';
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

            return ProductCard(product: product);
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
