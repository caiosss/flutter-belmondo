import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final String text;

  DialogBox(this.text);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(text),
      actions: [
        CupertinoDialogAction(child: Text("Ok"),isDefaultAction: true,),
      ],
    );
  }
}
