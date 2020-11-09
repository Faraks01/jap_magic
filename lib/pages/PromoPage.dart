import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jap_magic/themes.dart';

class PromoPage extends StatelessWidget {
  static final banners = <Image>[
    Image.asset(
      'assets/images/banner_1.png',
    ),
    Image.asset(
      'assets/images/banner_2.png',
    ),
    Image.asset(
      'assets/images/banner_3.png',
    ),
    Image.asset(
      'assets/images/banner_4.png',
    ),
    Image.asset(
      'assets/images/banner_5.png',
    ),
    Image.asset(
      'assets/images/banner_6.png',
    ),
    Image.asset(
      'assets/images/banner_7.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('JAPMAGIC'),
      ),
      child: Swiper(
        layout: SwiperLayout.STACK,
        containerHeight: height * 0.8,
        containerWidth: width * 0.9,
        itemWidth: width * 0.9,
        itemHeight: height * 0.8,
        autoplayDisableOnInteraction: true,
        scrollDirection: Axis.vertical,
        itemCount: banners.length,
        autoplay: true,
        itemBuilder: (context, index) {
          return Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                banners[index],
                CupertinoButton(
                  color: Colors.white,
                  child: Text(
                    'ПОДРОБНЕЕ',
                    style: AppButtonTheme.text,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
