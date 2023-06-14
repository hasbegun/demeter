import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String message;

  const CustomDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Text(message, style: const TextStyle(color: Colors.blueAccent),),
          const SizedBox(height: 15.0),
          TextButton(onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
          )
        ],
      )
      ),
    );
  }
}
