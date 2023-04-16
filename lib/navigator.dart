import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:warehouse_selective/constants/constants.dart';
import 'package:warehouse_selective/screens/add_products/add_product.dart';
import 'package:warehouse_selective/screens/analysis/analysis_screen.dart';
import 'package:warehouse_selective/screens/calculator/calculator.dart';
import 'package:warehouse_selective/screens/products/products.dart';
import 'package:warehouse_selective/screens/settings/settings.dart';

class navigator_screen extends StatefulWidget {
  const navigator_screen({super.key});

  @override
  State<navigator_screen> createState() => _navigator_screenState();
}

class _navigator_screenState extends State<navigator_screen> {
  int _bottomNavIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        padEnds: true,
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          analysis_screen(),
          products_screen(),
          calculator_screen(),
          settings_screen(),
        ],
      ), //destination screen
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.view_list,
        backgroundColor: Theme.of(context).cardColor,
        children: [
          SpeedDialChild(
            child: Image.asset(
              "assets/icons/product.png",
            ),
            label: "Ürün Ekle",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const add_product_screen(productid: ""),
                  ));
            },
          ),
          SpeedDialChild(
            child: Image.asset("assets/icons/raw.png", color: lblue),
            label: "Malzeme Ekle",
            onTap: () {
              print("object");
            },
          ),
          SpeedDialChild(
            child: Image.asset("assets/icons/package.png", color: lblue),
            label: "Paket Oluştur",
            onTap: () {
              print("object");
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Theme.of(context).cardColor,
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
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
            pageController.jumpToPage(_bottomNavIndex);
          });
        },
        activeColor: Theme.of(context).hintColor,
        blurEffect: true,
        splashColor: platinyum,
        splashRadius: 30,
        inactiveColor: Theme.of(context).shadowColor,
      ),
    );
  }
}
