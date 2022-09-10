import 'package:capacious/app_string.dart';
import 'package:flutter/material.dart';

class SimpleAlertDialog extends StatelessWidget {
  final String title;
  final String body;
  final Function() onTap;
  const SimpleAlertDialog({
    Key? key,
    required this.title,
    required this.body,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          child: const Text(AppString.no),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text(AppString.yes),
          onPressed: () {
            onTap();
          },
        )
      ],
    );
  }
}
