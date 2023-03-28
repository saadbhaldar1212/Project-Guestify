import 'package:flutter/material.dart';

class SDialog extends StatefulWidget {
  const SDialog({super.key, required this.titleText});

  final String titleText;

  @override
  State<SDialog> createState() => _SDialogState();
}

class _SDialogState extends State<SDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.red,
      title: Text(
        widget.titleText,
        style: const TextStyle(
          fontSize: 22,
        ),
        textAlign: TextAlign.center,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 38.0, right: 38.0, bottom: 18, top: 28),
          child: ElevatedButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            child: const Text('OK'),
          ),
        ),
      ],
    );
  }
}
