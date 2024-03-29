import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoginForm.dart';

class UnauthorizedContent extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.transparent,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: LoginForm(),
            ),
          ),
        ],
      ),
    );
  }
}
