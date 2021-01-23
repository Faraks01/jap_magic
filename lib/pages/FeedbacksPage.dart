import 'package:flutter/cupertino.dart';
import 'package:jap_magic/models/Product.dart';

class FeedbacksPageRouteArguments {
  final Product product;

  FeedbacksPageRouteArguments(this.product) : assert(product is Product);
}

class FeedbacksPage extends StatelessWidget {
  static const routeName = '/feedbacks-page';

  final Product product;

  FeedbacksPage({this.product}) : assert(product is Product);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Отзывы'),
      ),
      child: Container(),
    );
  }
}