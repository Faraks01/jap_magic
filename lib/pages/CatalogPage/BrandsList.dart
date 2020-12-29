import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jap_magic/models/Brand.dart';
import 'package:jap_magic/pages/BrandPage.dart';
import 'package:jap_magic/providers/BrandsProvider.dart';
import 'package:jap_magic/widgets/GridCard.dart';
import 'package:jap_magic/widgets/StoreList.dart';

class BrandsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreList<BrandsProvider, Brand>(
      limit: 1000,
      itemAspectRatio: 0.8,
      modelJsonConstructor: (json) => Brand.fromJson(json),
      renderListItem: (item, key) => GridCard(
        key: key,
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pushNamed(
              BrandPage.routeName,
              arguments: BrandPageRouteArguments(id: item.id));
        },
        heroTag: 'brand_picture_${item.id}',
        imageSrc: item.image,
        title: item.name,
      ),
    );
  }
}
