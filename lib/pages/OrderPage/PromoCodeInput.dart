import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/models/PromoCode.dart';
import 'package:jap_magic/providers/OrderProvider.dart';
import 'package:jap_magic/themes.dart';
import 'package:jap_magic/utilities/UpperCaseTextFormatter.dart';
import 'package:provider/provider.dart';

class PromoCodeInput extends StatefulWidget {
  @override
  _PromoCodeInputState createState() => _PromoCodeInputState();
}

class _PromoCodeInputState extends State<PromoCodeInput> {
  TextEditingController _controller;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderPwd = Provider.of<OrderProvider>(context, listen: false);

    return Material(
      color: Colors.transparent,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Selector<OrderProvider, PromoCode>(
            selector: (_, p) => p.promoCode,
            builder: (context, promoCode, child) {
              final promoCodeActive = promoCode != null && promoCode.active;

              return Container(
                color: Colors.white,
                child: TextField(
                  inputFormatters: [UpperCaseTextFormatter()],
                  controller: _controller,
                  cursorColor: Colors.purple[300],
                  decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  promoCodeActive ? Colors.green : Colors.grey,
                              width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: promoCodeActive
                                  ? Colors.green
                                  : Colors.purple[300],
                              width: 1.0)),
                      labelText: promoCodeActive
                          ? 'Промокод «${promoCode.code}» активирован!'
                          : 'Введите промокод',
                      labelStyle: AppTextTheme.smTitle.merge(TextStyle(
                          color: promoCodeActive
                              ? Colors.green
                              : Colors.purple[300])),
                      suffix: CupertinoButton(
                        color: Colors.purple[300],
                        minSize: 10,
                        padding: EdgeInsets.zero,
                        disabledColor: Colors.grey[300],
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                          child: Stack(
                            children: [
                              Text('Применить',
                                  style: TextStyle(
                                      color: _loading
                                          ? Colors.transparent
                                          : null)),
                              if (_loading)
                                Positioned.fill(
                                    child: Center(
                                        child: LinearProgressIndicator(
                                            backgroundColor: Colors.white)))
                            ],
                          ),
                        ),
                        onPressed: _loading
                            ? null
                            : () async {
                                setState(() {
                                  _loading = true;
                                });

                                await orderPwd
                                    .retrievePromoCode(_controller.value.text);

                                setState(() {
                                  _loading = false;
                                });
                              },
                      )),
                ),
              );
            },
          ),
          Selector<OrderProvider, bool>(
            selector: (_, p) {
              if (p.promoCode == null) return false;
              return p.summaryPrice < p.promoCode.minRequiredPrice;
            },
            builder: (context, active, child) => Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: active
                  ? Text(
                      'Минимальная требуемая сумма для применения промокода ${orderPwd.promoCode.minRequiredPrice}₽',
                      style: AppTextTheme.xsText
                          .merge(TextStyle(color: Colors.red[700])))
                  : Container(),
            ),
          )
        ],
      ),
    );
  }
}
