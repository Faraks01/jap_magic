import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/providers/FavoriteProductsProvider.dart';
import 'package:provider/provider.dart';

class ProductFavoriteButton extends StatelessWidget {
  final int productId;
  final double iconSize;

  const ProductFavoriteButton({
    Key key,
    this.productId,
    this.iconSize = 34,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProductsProvider =
        Provider.of<FavoriteProductsProvider>(context, listen: false);

    return Material(
      color: Colors.transparent,
      child: Selector<FavoriteProductsProvider, bool>(
        selector: (_, p) => p.productIds.contains(productId),
        builder: (_, isFavorite, __) => IconButton(
            icon: Icon(CupertinoIcons.heart_fill),
            iconSize: iconSize,
            color: isFavorite ? Colors.red[500] : Colors.grey[300],
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
