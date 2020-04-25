import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/default.i18n.dart';
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
            child: Text("Cancel".i18n),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: Text("Accept".i18n),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}
