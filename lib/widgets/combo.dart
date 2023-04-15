// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class customCombo extends StatefulWidget {
  final String text;
  final double textsize;
  late String? selectedValue;
  final Color color;
  final List<DropdownMenuItem<String>> items;
  final double iconsize;
  final double radius;
  final double bosluk;
  customCombo(
      {Key? key,
      required this.bosluk,
      required this.color,
      required this.iconsize,
      required this.items,
      required this.selectedValue,
      required this.radius,
      required this.text,
      required this.textsize})
      : super(key: key);

  @override
  _customComboState createState() => _customComboState();
}

class _customComboState extends State<customCombo> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: TextStyle(fontSize: widget.textsize),
            ),
            SizedBox(
              width: widget.bosluk,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                  value: widget.selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      widget.selectedValue = newValue!;
                      print(widget.selectedValue);
                    });
                  },
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.radius)),
                  iconSize: widget.iconsize,
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                  dropdownColor: widget.color,
                  items: widget.items),
            ),
          ],
        ),
      ),
    );
  }
}
