import 'package:flutter/cupertino.dart';

class BillingPage extends StatelessWidget {
  static const routeName = '/billing-page';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Оплата'),
      ),
      child: Container(),
    );
  }
}