import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/themes.dart';

class SlideMenuTab extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  SlideMenuTab({this.icon, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        onPressed: onTap,
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.black26, width: 1))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: Colors.black26),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(text, style: AppButtonTheme.text),
              )),
              Icon(CupertinoIcons.chevron_right, size: 20, color: Colors.black)
            ],
          ),
        ));
  }
}
