import 'package:flutter/material.dart';

Future<dynamic> showdialog({
  required BuildContext context,
  required String messege,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Signup Successful'),
        content: Text(messege),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
