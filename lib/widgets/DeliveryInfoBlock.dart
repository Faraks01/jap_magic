import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:jap_magic/pages/DeliveryInfoPage.dart';

import '../themes.dart';

class DeliveryInfoBlock extends StatelessWidget {
  const DeliveryInfoBlock({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey[400])),
          child: ListView(
            padding: const EdgeInsets.all(8),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(CupertinoIcons.person_fill,
                      color: Colors.black, size: 30),
                  SizedBox(width: 10),
                  Text.rich(TextSpan(
                      text: 'Курьер по Москве - завтра.\n',
                      style: AppTextTheme.smText,
                      children: [
                        TextSpan(
                            text: 'Бесплатно от 3000 рублей.',
                            style: TextStyle(color: Colors.orangeAccent))
                      ]))
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: const [
                  Icon(IcoFontIcons.fastDelivery,
                      color: Colors.black, size: 30),
                  SizedBox(width: 10),
                  Text.rich(TextSpan(
                      text: 'Доставка по России',
                      style: AppTextTheme.smText,
                      children: [
                        TextSpan(
                            text: ' от 190 рублей.',
                            style: TextStyle(color: Colors.orangeAccent))
                      ]))
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: const [
                  Icon(CupertinoIcons.cart_fill, color: Colors.black, size: 30),
                  SizedBox(width: 10),
                  Text.rich(TextSpan(
                      text: 'Самовывоз в розничном магазине.\n',
                      style: AppTextTheme.smText,
                      children: [
                        TextSpan(
                            text: 'Бесплатно.',
                            style: TextStyle(color: Colors.orangeAccent))
                      ]))
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: const [
                  Icon(CupertinoIcons.creditcard_fill,
                      color: Colors.black, size: 30),
                  SizedBox(width: 10),
                  Text.rich(TextSpan(
                      text: 'Оплата курьеру',
                      style: AppTextTheme.smText,
                      children: [
                        TextSpan(
                            text: ' картой',
                            style: TextStyle(color: Colors.orangeAccent)),
                        TextSpan(text: ' или'),
                        TextSpan(
                            text: ' наличными.',
                            style: TextStyle(color: Colors.orangeAccent))
                      ]))
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 36,
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(
                'Подробнее про условия доставки',
                style: TextStyle(color: Colors.grey[400]),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(DeliveryInfoPage.routeName);
              }),
        )
      ],
    );
  }
}
