import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoginForm.dart';

class UnauthorizedContent extends StatelessWidget {
  final bool keyboardOpen;

  UnauthorizedContent({this.keyboardOpen = false});

  Widget build(BuildContext context) {
    print(MediaQuery.of(context).viewInsets.bottom);
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final screenHeightPercent = screenHeight / 100;

    final formWidth = screenWidth * 0.9;
    final formHeight = screenHeight * 0.5;

    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.transparent,
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0.0, keyboardOpen ? -1 : 0),
            child: FractionallySizedBox(
              heightFactor: 0.5,
              widthFactor: 0.9,
              child: LoginForm(),
            ),
          ),
        ],
      ),
    );
  }
}

/**screenWidth / 2 - formWidth / 2,
                (screenHeight / 2 - formHeight / 2) -
                    (this.keyboardOpen ? 200 : 0) */
