import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/pages/UserPage/BottomSheetTab.dart';

class UserPage extends StatelessWidget {
  static const routeName = '/user-page';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Аккаунт'),
      ),
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Container(
              color: Colors.red,
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.2,
            maxChildSize: 0.6,
            builder: (BuildContext context, ScrollController scrollController) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    color: Colors.white,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: 8),
                        BottomSheetTab(
                          icon: CupertinoIcons.archivebox,
                          text: 'Мои заказы',
                          onTap: () {},
                        ),
                        BottomSheetTab(
                          icon: CupertinoIcons.heart,
                          text: 'Избранное',
                          onTap: () {},
                        ),
                        BottomSheetTab(
                          icon: CupertinoIcons.eye,
                          text: 'Просмотренные товары',
                          onTap: () {},
                        ),
                        BottomSheetTab(
                          icon: CupertinoIcons.play,
                          text: 'Карусель подарков',
                          onTap: () {},
                        ),
                        BottomSheetTab(
                          icon: CupertinoIcons.ticket,
                          text: 'Мои купоны',
                          onTap: () {},
                        ),
                        BottomSheetTab(
                          icon: CupertinoIcons.home,
                          text: 'Мои адреса',
                          onTap: () {},
                        ),
                        BottomSheetTab(
                          icon: CupertinoIcons.exclamationmark_bubble,
                          text: 'Обратная связь',
                          onTap: () {},
                        ),
                        BottomSheetTab(
                          icon: CupertinoIcons.creditcard,
                          text: 'Программа лояльности',
                          onTap: () {},
                        ),
                        BottomSheetTab(
                          icon: CupertinoIcons.question_circle,
                          text: 'Помощь',
                          onTap: () {},
                        ),
                        BottomSheetTab(
                          icon: CupertinoIcons.gear_alt,
                          text: 'Настройки',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
