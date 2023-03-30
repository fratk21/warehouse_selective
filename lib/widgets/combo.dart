// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class customCombo extends StatefulWidget {
  final String text;
  final double textsize;
  final String selectedValue;
  final Color color;
  final List<DropdownMenuItem<String>> items;
  final double iconsize;
  final double radius;
  final double bosluk;
  const customCombo(
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
  late String deneme = widget.selectedValue;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                value: deneme,
                onChanged: (String? newValue) {
                  setState(() {
                    deneme = newValue!;
                  });
                },
                borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
                iconSize: widget.iconsize,
                icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                dropdownColor: widget.color,
                items: widget.items),
          ),
        ],
      ),
    );
  }
}
