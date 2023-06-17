import 'package:flutter/cupertino.dart';

class CustomTextDisplay extends StatelessWidget {
  final String value;

  const CustomTextDisplay({
    super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 3.0),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(value,
              style: const TextStyle(fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
