import 'package:flutter/material.dart';

const List<String> list = <String>['Parent', 'Kinder', 'Elementary', 'Middle'];

class CustomDropdownButton extends StatefulWidget {
  final String labelText;

  const CustomDropdownButton({super.key, required this.labelText});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.labelText,
              style: const TextStyle(fontSize: 18.0,
                fontWeight: FontWeight.bold),),
          ),
          DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue,
            hint: const Text('Select the role'),
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.black54),
            underline: Container(
              height: 1.0,
              color: const Color(0xff939393),
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54),),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
