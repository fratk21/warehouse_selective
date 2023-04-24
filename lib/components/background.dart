import 'package:flutter/material.dart';
import 'package:warehouse_selective/constants/constants.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/images/top1.png",
              width: size.width,
              color: Color(0xFF2196F3),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/images/top2.png",
                width: size.width, color: Color(0xFF009688)),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images/bottom1.png",
                width: size.width, color: Color(0xFF2196F3)),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images/bottom2.png",
                width: size.width, color: Color(0xFF009688)),
          ),
          child
        ],
      ),
    );
  }
}
