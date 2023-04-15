import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:warehouse_selective/constants/constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: Color(0xFF212121)),
      cardColor: Color(0xFF424242),
      scaffoldBackgroundColor: Color(0xFF212121),
      primaryColor: Color(0xFF212121),
      colorScheme: ColorScheme.dark(),
      iconTheme: IconThemeData(color: Color(0xFFBDBDBD)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF2196F3),
          foregroundColor: Colors.white,
          textStyle: TextStyle(color: white),
        ),
      ));

  static final lightTheme = ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: Color(0xFF009688)),
      cardColor: Color(0xFFFFFFFF),
      scaffoldBackgroundColor: Color(0xFFF5F5F5),
      primaryColor: Colors.white,
      colorScheme: ColorScheme.light(),
      textTheme: TextTheme(),
      iconTheme: IconThemeData(color: Color(0xFF757575)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF009688),
          foregroundColor: Colors.white,
          textStyle: TextStyle(color: white),
        ),
      ));
}
