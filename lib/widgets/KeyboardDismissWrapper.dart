import 'package:flutter/material.dart';

class KeyboardDismissWrapper extends StatelessWidget {
  final Widget child;
  final Function onDismiss;

  const KeyboardDismissWrapper({Key key, this.onDismiss, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (onDismiss != null) onDismiss();
      },
      child: child,
    );
  }
}
