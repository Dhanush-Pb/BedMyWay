import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final Function onPressed;

  const CustomAlert({
    Key? key,
    required this.title,
    required this.content,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onPressed();
          },
          child: Text(buttonText),
        ),
      ],
    );
  }
}
