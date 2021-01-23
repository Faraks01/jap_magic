import 'package:flutter/cupertino.dart';

class DeliveryInfoPage extends StatelessWidget {
  static const routeName = '/delivery-info-page';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Доставка'),
      ),
      child: Container(),
    );
  }
}