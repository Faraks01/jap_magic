import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/models/Product.dart';

class ProductShareButton extends StatelessWidget {
  final Product product;
  final double iconSize;
  final EdgeInsets padding;

  const ProductShareButton(
      {Key key,
      @required this.product,
      this.iconSize = 34,
      this.padding = EdgeInsets.zero})
      : assert(product is Product),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: CupertinoButton(
          padding: padding,
          child: Icon(
            CupertinoIcons.square_arrow_up,
            color: Colors.grey[300],
            size: iconSize,
          ),
          onPressed: () {}),
    );
  }
}
