import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/providers/OrderProvider.dart';
import 'package:jap_magic/themes.dart';
import 'package:jap_magic/utilities/SimpleUtilities.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class PriceInfoBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<OrderProvider, Tuple3<int, int, int>>(
      selector: (_, p) =>
          Tuple3(p.summaryProducts, p.summaryPrice,
              p.summaryPriceAfterDiscount),
      builder: (context, payload, child) {
        final productsKeyword = SimpleUtilities.setWordEnding(
          word: 'това',
          count: payload.item1,
          singleEnding: 'р',
          pluralEnding1: 'ра',
          pluralEnding2: 'ров',
        );

        final hasDiscount = payload.item3 < payload.item2;

        return SizedBox(
          height: 60,
          width: double.infinity,
          child: Center(
            child: Text.rich(TextSpan(
                text: '${payload.item1} $productsKeyword на сумму: ',
                style: AppTextTheme.lgTitle,
                children: [
                  if (!hasDiscount)
                    TextSpan(text: '${payload.item2}₽'),
                  if (hasDiscount)
                    TextSpan(text: '${payload.item3}₽ '),
                  if (hasDiscount)
                    TextSpan(
                        text: '${payload.item2}₽',
                        style: AppTextTheme.mdText.merge(TextStyle(
                            color: Colors.red[700],
                            decoration: TextDecoration.lineThrough))),
                ])),
          ),
        );
      },
    );
  }
}