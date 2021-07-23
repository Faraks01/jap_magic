import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/pages/FeedbackPage.dart';
import 'package:jap_magic/pages/RecentlyViewedProductsPage.dart';

import 'LoyaltyCard.dart';
import 'SlideMenuTab.dart';

class AuthorizedContent extends StatelessWidget {
  final Function(double scaling) handleBackgroundScalingChange;

  const AuthorizedContent(
      {Key key, @required this.handleBackgroundScalingChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context, rootNavigator: true);

    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.transparent,
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.2),
            child: LoyaltyCard(),
          ),
        ),
        NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            this.handleBackgroundScalingChange(1 + (notification.extent - 0.2));

            return true;
          },
          child: DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.2,
            maxChildSize: 0.7,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                physics: ClampingScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                      )),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: 8),
                      SlideMenuTab(
                        icon: CupertinoIcons.archivebox,
                        text: 'Мои заказы',
                        onTap: () {},
                      ),
                      SlideMenuTab(
                        icon: CupertinoIcons.heart,
                        text: 'Избранное',
                        onTap: () {},
                      ),
                      SlideMenuTab(
                        icon: CupertinoIcons.eye,
                        text: 'Просмотренные товары',
                        onTap: () {
                          nav.pushNamed(RecentlyViewedProductsPage.routeName);
                        },
                      ),
                      SlideMenuTab(
                        icon: CupertinoIcons.play,
                        text: 'Карусель подарков',
                        onTap: () {},
                      ),
                      SlideMenuTab(
                        icon: CupertinoIcons.ticket,
                        text: 'Мои купоны',
                        onTap: () {},
                      ),
                      SlideMenuTab(
                        icon: CupertinoIcons.home,
                        text: 'Мои адреса',
                        onTap: () {},
                      ),
                      SlideMenuTab(
                        icon: CupertinoIcons.exclamationmark_bubble,
                        text: 'Обратная связь',
                        onTap: () {
                          nav.pushNamed(FeedbackPage.routeName);
                        },
                      ),
                      SlideMenuTab(
                        icon: CupertinoIcons.creditcard,
                        text: 'Программа лояльности',
                        onTap: () {},
                      ),
                      SlideMenuTab(
                        icon: CupertinoIcons.question_circle,
                        text: 'Помощь',
                        onTap: () {},
                      ),
                      SlideMenuTab(
                        icon: CupertinoIcons.gear_alt,
                        text: 'Настройки',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
