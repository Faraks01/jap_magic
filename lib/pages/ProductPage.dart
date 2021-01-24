import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/models/Product.dart';
import 'package:jap_magic/providers/BrandsProvider.dart';
import 'package:jap_magic/providers/OrderProvider.dart';
import 'package:jap_magic/providers/ProductsProvider.dart';
import 'package:jap_magic/themes.dart';
import 'package:jap_magic/utilities/SimpleUtilities.dart';
import 'package:jap_magic/utilities/WithPromptDialog.dart';
import 'package:jap_magic/widgets/DeliveryInfoBlock.dart';
import 'package:jap_magic/widgets/ProductFavoriteButton.dart';
import 'package:jap_magic/widgets/ProductShareButton.dart';
import 'package:jap_magic/widgets/TextWithInlineVideo.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'FeedbacksPage.dart';

class ProductPageRouteArguments {
  final int id;

  ProductPageRouteArguments({@required this.id});
}

class ProductPage extends StatelessWidget with WithPromptDialog {
  static const routeName = '/product-page';

  final Product product;
  final id;

  ProductPage({@required this.product, this.id})
      : assert(product == null ? id is int : product is Product);

  Widget buildContent(BuildContext context) {
    final nav = Navigator.of(context);
    final orderPvd = Provider.of<OrderProvider>(context, listen: false);

    final brand =
        Provider.of<BrandsProvider>(context, listen: false).map[product.brand];

    final feedbackKeyword = SimpleUtilities.setWordEnding(
      word: 'отзы',
      count: product.amountOfFeedbacks,
      singleEnding: 'в',
      pluralEnding1: 'ва',
      pluralEnding2: 'вов',
    );

    final bottomOffset = MediaQuery.of(context).viewPadding.bottom;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 40,
              pinned: true,
              expandedHeight: 220,
              backgroundColor: Colors.black,
              leading: CupertinoButton(
                  padding: const EdgeInsets.fromLTRB(0, 0, 26, 10),
                  child: Icon(
                    CupertinoIcons.back,
                    color: Colors.grey[300],
                    size: 36,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              actions: [
                ProductShareButton(product: product, iconSize: 32),
                ProductFavoriteButton(productId: product.id, iconSize: 36),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  product.image,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 6),
                    Text(
                      product.name,
                      style: AppTextTheme.lgTitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Линейка товаров',
                      style: AppTextTheme.lgText,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      brand.name,
                      style: AppTextTheme.mdText
                          .merge(TextStyle(color: Colors.grey[600])),
                      textAlign: TextAlign.center,
                    ),
                    Divider(color: Colors.grey[500]),
                    Text('Параметры', style: AppTextTheme.mdTitle),
                    const SizedBox(height: 6),
                    Text.rich(TextSpan(
                      text: "Артикул: ",
                      style: AppTextTheme.smTitle,
                      children: [
                        TextSpan(
                            text: product.barcode,
                            style: AppTextTheme.smText
                                .merge(TextStyle(color: Colors.grey[600])))
                      ],
                    )),
                    ...product.propertiesPairs
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text.rich(TextSpan(
                                text: "${e[0]}: ",
                                style: AppTextTheme.smTitle,
                                children: [
                                  TextSpan(
                                      text: e[1],
                                      style: AppTextTheme.smText.merge(
                                          TextStyle(color: Colors.grey[600])))
                                ],
                              )),
                            ))
                        .toList(),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            SmoothStarRating(
                                allowHalfRating: false,
                                onRated: (v) {
                                  print(v);
                                },
                                starCount: 5,
                                rating: product.ratingScore,
                                defaultIconData: CupertinoIcons.star,
                                filledIconData: CupertinoIcons.star_fill,
                                halfFilledIconData:
                                    CupertinoIcons.star_lefthalf_fill,
                                size: 30,
                                isReadOnly: true,
                                color: Colors.yellow[600],
                                borderColor: Colors.yellow[600],
                                spacing: 0.0),
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                '${product.amountOfFeedbacks} $feedbackKeyword',
                                style: AppTextTheme.smText
                                    .merge(TextStyle(color: Colors.grey[600])),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          nav.pushNamed(FeedbacksPage.routeName,
                              arguments: FeedbacksPageRouteArguments(product));
                        }),
                    Divider(color: Colors.grey[500]),

                    Text('Схожие товары', style: AppTextTheme.mdTitle),

                    const SizedBox(height: 6),

                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: product.similarProductsInfo
                              .map((pInfo) => Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        child: Image.network(
                                          pInfo.values.first,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                        onPressed: () {
                                          nav.pushReplacementNamed(
                                              ProductPage.routeName,
                                              arguments:
                                                  ProductPageRouteArguments(
                                                      id: int.parse(
                                                          pInfo.keys.first)));
                                        }),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),

                    Divider(color: Colors.grey[500]),

                    TextWithInlineVideo(
                      text: product.description,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: DeliveryInfoBlock(),
                    ) // bottom offset
                  ],
                )
              ]),
            ),
          ],
        )),
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: -4,
                blurRadius: 10,
                offset: Offset(0, -10), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: Center(
                child:
                    Text('${product.intPrice} ₽', style: AppTextTheme.lgTitle),
              )),
              Expanded(
                child: Selector<OrderProvider, bool>(
                  selector: (_, p) => p.map.containsKey(product.id),
                  builder: (context, inCart, child) => CupertinoButton(
                    borderRadius: BorderRadius.zero,
                    color: Colors.grey[300],
                    disabledColor: Colors.red[400],
                    padding: EdgeInsets.zero,
                    child: Text(inCart ? 'Уже в корзине' : 'Добавить в корзину',
                        style: AppTextTheme.xsTitle.merge(TextStyle(
                            color: inCart ? Colors.white : Colors.black))),
                    onPressed: inCart
                        ? null
                        : () {
                            orderPvd.addListItem(product);
                            orderPvd.notifyListeners();
                          },
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: bottomOffset)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final productsPvd = Provider.of<ProductsProvider>(context, listen: false);

    bool _dialogExists = false;

    return CupertinoPageScaffold(
        backgroundColor: Colors.black,
        child: SafeArea(
          bottom: false,
          child: Container(
            color: Colors.white,
            child: product == null
                ? FutureBuilder(
                    future: productsPvd.fetchItem(
                        id: id,
                        api: productsPvd.fetchApi.makeRequest,
                        modelJsonConstructor: (json) => Product.fromJson(json)),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: CupertinoActivityIndicator(
                          radius: 30,
                        ));
                      } else if (snapshot.data != 200) {
                        Future.delayed(Duration(milliseconds: 300), () {
                          if (_dialogExists) return;

                          _dialogExists = true;

                          displayDialog(
                              context: context,
                              message: 'Не удалось загрузить товар!',
                              onCancel: () {
                                Navigator.of(context).pop();
                              });
                        });

                        return Center(
                            child: CupertinoActivityIndicator(
                          radius: 30,
                        ));
                      } else {
                        return buildContent(context);
                      }
                    })
                : buildContent(context),
          ),
        ));
  }
}
