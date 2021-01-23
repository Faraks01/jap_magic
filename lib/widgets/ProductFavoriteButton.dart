import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/providers/FavoriteProductsProvider.dart';
import 'package:provider/provider.dart';

class ProductFavoriteButton extends StatelessWidget {
  final int productId;
  final double iconSize;
  final EdgeInsets padding;

  const ProductFavoriteButton(
      {Key key,
      @required this.productId,
      this.iconSize = 34,
      this.padding = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProductsProvider =
        Provider.of<FavoriteProductsProvider>(context, listen: false);

    return Material(
      color: Colors.transparent,
      child: Selector<FavoriteProductsProvider, bool>(
        selector: (_, p) => p.productIds.contains(productId),
        builder: (_, isFavorite, __) => CupertinoButton(
            padding: padding,
            child: Icon(
              CupertinoIcons.heart_fill,
              color: isFavorite ? Colors.red[500] : Colors.grey[300],
              size: iconSize,
            ),
            onPressed: () {
              if (isFavorite) {
                favoriteProductsProvider.removeId(productId);
              } else {
                favoriteProductsProvider.addId(productId);
              }
            }),
      ),
    );
  }
}
