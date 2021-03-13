import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jap_magic/pages/BillingPage.dart';
import 'package:jap_magic/pages/OrderPage/PriceInfoBar.dart';
import 'package:jap_magic/providers/OrderProvider.dart';
import 'package:jap_magic/themes.dart';
import 'package:jap_magic/widgets/DeliveryInfoBlock.dart';
import 'package:jap_magic/widgets/KeyboardDismissWrapper.dart';
import 'package:jap_magic/widgets/ProductGridCard.dart';
import 'package:provider/provider.dart';

import 'OrderProductCard.dart';
import 'PromoCodeInput.dart';

class OrderPage extends StatelessWidget {
  static const routeName = '/order-page';

  final SlidableController slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context, listen: false);

    return KeyboardDismissWrapper(
      onDismiss: () {
        slidableController.activeState.close();
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Корзина', style: TextStyle(color: Colors.white)),
        ),
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              PriceInfoBar(),
              Selector<OrderProvider, int>(
                selector: (_, p) => p.amountOfProducts,
                builder: (context, amountOfProducts, child) => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: amountOfProducts,
                  itemBuilder: (context, index) {
                    final product = orderPvd.map[orderPvd.payloadKeys[index]];

                    return OrderProductCard(
                      product,
                      slidableController: slidableController,
                      firstItemInList: index == 0,
                      key: Key('${product.id}'),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Ранее просмотренные товары',
                    style: AppTextTheme.lgTitle,
                  ),
                ),
              ),
              Selector<OrderProvider, int>(
                selector: (_, p) => p.recentlyViewedProducts.length,
                builder: (context, recentlyViewedProductsLength, child) =>
                    SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: recentlyViewedProductsLength,
                    itemBuilder: (context, index) {
                      final product = orderPvd.recentlyViewedProducts[index];
                      final isLastItem =
                          index == recentlyViewedProductsLength - 1;

                      return Padding(
                        padding:
                            EdgeInsets.fromLTRB(8, 0, isLastItem ? 8 : 0, 0),
                        child: SizedBox(
                          width: 160,
                          child: ProductGridCard(
                              product: product,
                              key: Key('${product.id}_recent')),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: PromoCodeInput(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: DeliveryInfoBlock(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                child: CupertinoButton(
                  color: Colors.purple[300],
                  padding: EdgeInsets.zero,
                  child: Text('Перейти к оплате',
                      style: AppButtonTheme.text
                          .merge(TextStyle(color: Colors.white))),
                  onPressed: () {
                    // Navigator.of(context, rootNavigator: true)
                    //     .pushNamed(BillingPage.routeName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
