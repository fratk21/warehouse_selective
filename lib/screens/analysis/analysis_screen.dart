import 'package:flutter/material.dart';
import 'package:warehouse_selective/constants/constants.dart';
import 'package:warehouse_selective/widgets/appbar.dart';

class analysis_screen extends StatefulWidget {
  const analysis_screen({super.key});

  @override
  State<analysis_screen> createState() => _analysis_screenState();
}

class _analysis_screenState extends State<analysis_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(false, context, orange, "label", true, () => null),
    );
  }
}
