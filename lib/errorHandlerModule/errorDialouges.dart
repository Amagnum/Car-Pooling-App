import 'package:flutter/material.dart';

void errorDialog(
    {@required BuildContext context,
    @required String title,
    @required String body}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(body + '\n\nPlease try again'),
        actions: <Widget>[
          FlatButton(
            child: Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
