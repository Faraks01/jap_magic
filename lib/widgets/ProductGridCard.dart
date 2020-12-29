import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/models/Product.dart';
import 'package:jap_magic/providers/BrandsProvider.dart';
import 'package:jap_magic/themes.dart';
import 'package:jap_magic/widgets/ProductFavoriteButton.dart';
import 'package:provider/provider.dart';

class ProductGridCard extends StatelessWidget {
  final Product product;

  const ProductGridCard({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brandName = Provider.of<BrandsProvider>(context, listen: false)
        .map[product.brand]
        .name;

    return CupertinoButton(
      onPressed: () {},
      padding: EdgeInsets.zero,
      child: Card(
        elevation: 2,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: 'product_picture_${product.id}',
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: ProductFavoriteButton(productId: product.id),
                    )
                  ],
                ),
              )),
              ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      brandName,
                      textAlign: TextAlign.left,
                      style: AppTextTheme.smTitle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextTheme.smText
                          .merge(TextStyle(color: Colors.grey[700])),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${product.intPrice} ₽',
                            style: AppTextTheme.smTitle),
                        IconButton(
                            icon: Icon(CupertinoIcons.cart),
                            iconSize: 30,
                            onPressed: () {})
                      ],
                    )
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
