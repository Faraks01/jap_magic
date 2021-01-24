import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class WithSubmitDialog {
  Future displayDialog(
      {BuildContext context,
      String message = "Are you sure that you want to delete this item?",
      VoidCallback onAccept,
      VoidCallback onCancel}) {
    return showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(message),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                onCancel();
              },
              child: Text('Отмена'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: false,
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                onAccept();
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
