import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse_selective/constants/thema_provider.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_selective/navigator.dart';
import 'package:warehouse_selective/screens/onboarding/onboarding_pageview.dart';
import 'package:warehouse_selective/services/finance.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    finance().fetchDolar();
    finance().fetcheuro();
    finance().fetchsterlin();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            title: 'WareHouse',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: FirebaseAuth.instance.currentUser?.uid == null
                ? onboarding_pageview()
                : navigator_screen(),
          );
        },
      );
}
