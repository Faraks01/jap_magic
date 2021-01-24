import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class WithPromptDialog {
  Future displayDialog(
      {@required BuildContext context, @required String message, VoidCallback onCancel}) {
    return showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(message),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: false,
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                if (onCancel != null) onCancel();
              },
              child: Text('Ок'),
            ),
          ],
          // elevation: 24,
        );
      },
    );
  }
}
