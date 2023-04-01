import 'package:flutter/material.dart';

class products_screen extends StatefulWidget {
  const products_screen({super.key});

  @override
  State<products_screen> createState() => _products_screenState();
}

class _products_screenState extends State<products_screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("data"),
      ),
    );
  }
}
