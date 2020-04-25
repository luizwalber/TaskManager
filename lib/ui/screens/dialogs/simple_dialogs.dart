import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/locale/app_localization.dart';
import 'package:task_manager/utils/enums.dart';

Future<ConfirmAction> confirmDialog(
    BuildContext context, String title, String description) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          FlatButton(
            child: Text(AppLocalization.of(context).cancel),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: Text(AppLocalization.of(context).accept),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}
