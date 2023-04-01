import 'package:flutter/material.dart';
import 'package:warehouse_selective/constants/constants.dart';

class inputtext extends StatefulWidget {
  inputtext(
      {super.key,
      required this.context,
      required this.control,
      required this.height,
      required this.width,
      required this.maxline,
      required this.maxLengh,
      required this.hinttext,
      required this.icons,
      required this.texttip,
      required this.gizli,
      required this.color,
      required this.color2,
      required this.elevation});
  final BuildContext context;
  final TextEditingController control;
  final double height;
  final double width;
  final int maxline;
  final int maxLengh;
  final String hinttext;
  final IconData icons;
  final TextInputType texttip;
  final bool gizli;
  final Color color;
  final Color color2;
  final double elevation;
  @override
  State<inputtext> createState() => _inputtextState();
}

class _inputtextState extends State<inputtext> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: widget.elevation,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Icon(
              widget.icons,
              color: widget.color2,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: TextField(
              keyboardType: widget.texttip,
              obscureText: widget.gizli,
              maxLines: widget.maxline,
              controller: widget.control,
              cursorColor: orange,
              decoration: InputDecoration(
                labelText: widget.hinttext,
                border: InputBorder.none,
              ),
            )),
          ],
        ),
      ),
    );
  }
}

Widget inputtex(
  BuildContext context,
  TextEditingController control,
  double height,
  double width,
  int maxline,
  int maxLengh,
  String hinttext,
  IconData icons,
  TextInputType texttip,
  bool gizli,
  Color color,
  Color color2,
  double elevation,
) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
    elevation: elevation,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Icon(
            icons,
            color: color2,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: TextField(
            keyboardType: texttip,
            obscureText: gizli,
            maxLines: maxline,
            controller: control,
            cursorColor: orange,
            decoration: InputDecoration(
              labelText: hinttext,
              labelStyle: TextStyle(color: Colors.black),
              border: InputBorder.none,
            ),
          )),
        ],
      ),
    ),
  );
}
