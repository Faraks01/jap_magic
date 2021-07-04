import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/models/User.dart';
import 'package:jap_magic/pages/UserPage/LoyaltyCard.dart';
import 'package:jap_magic/pages/UserPage/SlideMenuTab.dart';
import 'package:jap_magic/pages/UserPage/UnauthorizedContent.dart';
import 'package:jap_magic/providers/UsersProvider.dart';
import 'package:jap_magic/widgets/KeyboardDismissWrapper.dart';
import 'package:provider/provider.dart';

import 'AuthorizedContent.dart';

class UserPage extends StatefulWidget {
  static const routeName = '/user-page';

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  double _backgroundScaling = 1;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissWrapper(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Аккаунт'),
        ),
        child: Stack(
          children: <Widget>[
            Transform.scale(
              scale: _backgroundScaling,
              child: Image.asset('assets/images/background.jpg',
                  height: double.infinity, fit: BoxFit.cover),
            ),
            Selector<UsersProvider, User>(
              selector: (_, p) => p.mainUser,
              builder: (context, mainUser, child) {
                print(MediaQuery.of(context));
                if (null != null) {
                  return AuthorizedContent(
                      handleBackgroundScalingChange: (scaling) {
                    setState(() {
                      _backgroundScaling = scaling;
                    });
                  });
                } else {
                  return UnauthorizedContent();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
