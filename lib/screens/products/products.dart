import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_selective/constants/thema_provider.dart';

class products_screen extends StatefulWidget {
  const products_screen({super.key});

  @override
  State<products_screen> createState() => _products_screenState();
}

class _products_screenState extends State<products_screen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        child: Center(
          child: Text("data"),
        ),
      ),
    );
  }
}
