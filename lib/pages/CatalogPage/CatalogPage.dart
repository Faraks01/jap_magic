import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/pages/CatalogPage/BrandsList.dart';
import 'package:jap_magic/pages/CatalogPage/CategoriesList.dart';
import 'package:jap_magic/themes.dart';

class CatalogPage extends StatelessWidget {
  static const routeName = '/catalog-page';

  final _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  void updateCurrentPage(int value) {
    _currentPage.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('КАТАЛОГ'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder<int>(
            valueListenable: _currentPage,
            builder: (context, currentPage, child) =>
                CupertinoSlidingSegmentedControl(
              padding: EdgeInsets.all(5),
              groupValue: currentPage,
              children: {
                0: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Категории',
                    style: AppButtonTheme.text,
                  ),
                ),
                1: Padding(
                  padding: EdgeInsets.zero,
                  child: Text(
                    'Бренды',
                    style: AppButtonTheme.text,
                  ),
                ),
              },
              onValueChanged: (value) {
                updateCurrentPage(value);
                _pageController.animateToPage(value,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut);
              },
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: updateCurrentPage,
              controller: _pageController,
              children: [
                CategoriesList(),
                BrandsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
