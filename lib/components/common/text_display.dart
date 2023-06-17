import 'package:flutter/cupertino.dart';

class TextDisplay extends StatelessWidget {
  const TextDisplay({
    super.key,
    required this.text,
    required this.style,
  });

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: style),
    );
  }
}