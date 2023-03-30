import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:warehouse_selective/constants/constants.dart';
import 'package:warehouse_selective/screens/add_products/add_products.dart';

class navigator_screen extends StatefulWidget {
  const navigator_screen({super.key});

  @override
  State<navigator_screen> createState() => _navigator_screenState();
}

class _navigator_screenState extends State<navigator_screen> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(), //destination screen
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.view_list,
        backgroundColor: orange,
        children: [
          SpeedDialChild(
            child: Image.asset("assets/icons/product.png", color: orange),
            label: "Ürün Ekle",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const add_product(),
                  ));
            },
          ),
          SpeedDialChild(
            child: Image.asset("assets/icons/raw.png", color: orange),
            label: "Malzeme Ekle",
            onTap: () {
              print("object");
            },
          ),
          SpeedDialChild(
            child: Image.asset("assets/icons/package.png", color: orange),
            label: "Paket Oluştur",
            onTap: () {
              print("object");
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.poll_rounded,
          Icons.warehouse_rounded,
          Icons.calculate,
          Icons.settings,
        ],
        iconSize: 25,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        activeColor: orange,
        blurEffect: true,
        splashColor: orange,
        splashRadius: 30,
      ),
    );
  }
}
