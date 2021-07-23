import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/themes.dart';
import 'package:jap_magic/widgets/Hyperlink.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FeedbackPage extends StatelessWidget {
  static const routeName = "/feedback-page";
  final String navTitle = "Обратная связь";

  FeedbackPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(navTitle, style: TextStyle(color: Colors.white)),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text("Мобильная связь", style: AppTextTheme.lgTitle),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Hyperlink(
                "+7-916-954-17-71",
                style: AppTextTheme.lgText,
                url: "tel:+79169541771",
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Hyperlink(
                "+7-916-996-17-71",
                style: AppTextTheme.lgText,
                url: "tel:+79169961771",
              ),
            ),
          ),
          const SizedBox(height: 6),
          Divider(color: Colors.black),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text("Почта", style: AppTextTheme.lgTitle),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Hyperlink(
                "japmagic@yandex.ru",
                style: AppTextTheme.lgText,
                url: "mailto:japmagic@yandex.ru",
              ),
            ),
          ),
          const SizedBox(height: 6),
          Divider(color: Colors.black),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text("Социальные сети", style: AppTextTheme.lgTitle),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(MdiIcons.instagram, color: Colors.pinkAccent[400]),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Hyperlink(
                      "Instagram",
                      style: AppTextTheme.lgText,
                      url: "https://www.instagram.com/japmagic/",
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(MdiIcons.vk, color: Colors.blue[800]),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Hyperlink(
                      "ВКонтакте",
                      style: AppTextTheme.lgText,
                      url: "https://vk.com/public179987449",
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}