import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/themes.dart';

class GridCard extends StatelessWidget {
  final String heroTag;
  final String imageSrc;
  final String title;
  final VoidCallback onPressed;
  final BoxFit imageFit;

  const GridCard(
      {Key key,
      this.heroTag,
      this.imageSrc,
      this.title,
      this.onPressed,
      this.imageFit = BoxFit.contain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Card(
        elevation: 10,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                width: double.infinity,
                child: Hero(
                  tag: heroTag,
                  child: Image.network(
                    imageSrc,
                    fit: imageFit,
                  ),
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: AppTextTheme.smTitle,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
