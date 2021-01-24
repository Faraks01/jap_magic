import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/models/Category.dart';
import 'package:jap_magic/models/Product.dart';
import 'package:jap_magic/providers/ProductsProvider.dart';
import 'package:jap_magic/providers/SubcategoriesProvider.dart';
import 'package:jap_magic/widgets/HorizontalScrollBars.dart';
import 'package:jap_magic/widgets/ProductGridCard.dart';
import 'package:jap_magic/widgets/StoreList.dart';
import 'package:provider/provider.dart';

class CategoryPageRouteArguments {
  final int id;

  CategoryPageRouteArguments({
    @required this.id,
  });
}

class CategoryPage extends StatefulWidget {
  static const routeName = '/category-page';

  final Category category;

  const CategoryPage({Key key, @required this.category}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectedSubcategoryId = 999;

  @override
  Widget build(BuildContext context) {
    final subcategoriesProvider =
        Provider.of<SubcategoriesProvider>(context, listen: false);

    final subcategoriesByCategory = subcategoriesProvider.map.values
        .where((e) => e.category == widget.category.id)
        .toList();

    final subcategoriesQueryParam =
        subcategoriesByCategory.map((e) => e.id).join(",");

    final topMenuBars = [
      BarMeta(id: 999, text: 'Все'),
      ...?subcategoriesByCategory
          .map((c) => BarMeta(id: c.id, text: c.name))
          .toList()
    ];

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle:
            Text(widget.category.name, style: TextStyle(color: Colors.white)),
      ),
      child: StoreList<ProductsProvider, Product>(
        bottomViewPadding: true,
        limit: 10,
        itemAspectRatio: 0.6,
        queryParams: {
          'subcategories':
              '${_selectedSubcategoryId == 999 ? subcategoriesQueryParam : _selectedSubcategoryId}'
        },
        appBar: SliverAppBar(
          pinned: true,
          expandedHeight: 220,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              widget.category.image,
              height: 220,
              fit: BoxFit.cover,
            ),
          ),
        ),
        headerWidgets: [
          HorizontalScrollBars(
            listPadding: const EdgeInsets.only(top: 13),
            bars: topMenuBars,
            activeBarId: _selectedSubcategoryId,
            onBarPressed: (barMeta) {
              setState(() {
                _selectedSubcategoryId = barMeta.id;
              });
            },
          )
        ],
        modelJsonConstructor: (json) => Product.fromJson(json),
        renderListItem: (item, key) => ProductGridCard(product: item, key: key),
      ),
    );
  }
}
