import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warehouse_selective/navigator.dart';
import 'package:warehouse_selective/screens/login/login.dart';
import 'package:warehouse_selective/services/auth_service.dart';
import 'package:warehouse_selective/services/firestoreMethods.dart';

import '../../constants/thema_provider.dart';

class settings_screen extends StatefulWidget {
  const settings_screen({super.key});

  @override
  State<settings_screen> createState() => _settings_screenState();
}

class _settings_screenState extends State<settings_screen> {
  final Uri _url = Uri.parse('https://www.selectiveyazilim.com/');

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(automaticallyImplyLeading: false, title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // User card

            SettingsGroup(
              settingsGroupTitle: "Uygulama Ayarları",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: themeProvider.isDarkMode
                      ? Icons.sunny
                      : Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor:
                        themeProvider.isDarkMode ? Colors.yellow : Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.black,
                  ),
                  title: themeProvider.isDarkMode ? "Light mode" : 'Dark mode',
                  subtitle: "Automatic",
                  trailing: Switch.adaptive(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        final provider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        provider.toggleTheme(value);
                        firestoreservices().thema(value);
                      });
                    },
                  ),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () async {
                    await launchUrl(_url);
                  },
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor,
                  ),
                  title: 'About',
                  subtitle: "Selective Dünyasını Keşfedin",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: "Kullanıcı Ayarları",
              items: [
                SettingsItem(
                  onTap: () {
                    auth_services().out();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  icons: Icons.exit_to_app_rounded,
                  title: "Çıkış Yap",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
