import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/models/Category.dart';
import 'package:jap_magic/providers/CategoriesProvider.dart';
import 'package:jap_magic/widgets/GridCard.dart';
import 'package:jap_magic/widgets/StoreList.dart';

class CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreList<CategoriesProvider, Category>(
      limit: 1000,
      itemAspectRatio: 0.8,
      modelJsonConstructor: (json) => Category.fromJson(json),
      renderListItem: (item, key) => GridCard(
        key: key,
        onPressed: () {
          // Navigator.of(context, rootNavigator: true).pushNamed(
          //     CategoryPage.routeName,
          //     arguments: CategoryPageRouteArguments(id: item.id));
        },
        heroTag: 'category_picture_${item.id}',
        imageSrc: item.image,
        title: item.name,
      ),
    );
  }
}
