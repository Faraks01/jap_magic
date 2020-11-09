import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/themes.dart';

class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  int _currentPage = 0;
  final _pageController = PageController();

  void updateCurrentPage(int value) {
    setState(() {
      _currentPage = value;
    });
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
          CupertinoSlidingSegmentedControl(
            padding: EdgeInsets.all(5),
            groupValue: _currentPage,
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
          Expanded(
            child: PageView(
              onPageChanged: updateCurrentPage,
              controller: _pageController,
              children: [
                Placeholder(),
                Placeholder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
