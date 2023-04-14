import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/thema_provider.dart';

class settings_screen extends StatefulWidget {
  const settings_screen({super.key});

  @override
  State<settings_screen> createState() => _settings_screenState();
}

class _settings_screenState extends State<settings_screen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // User card

            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.pencil_outline,
                  iconStyle: IconStyle(),
                  title: 'Hesabımı Duzenle',
                  subtitle: "Giriş ve Hesap bilgileri",
                ),
                SettingsItem(
                  onTap: () {},
                  backgroundColor: Theme.of(context).cardColor,
                  icons: Icons.language_outlined,
                  iconStyle: IconStyle(),
                  title: 'Appearance',
                  titleStyle: Theme.of(context).textTheme.bodyMedium,
                  subtitle: "Make Ziar'App yours",
                ),
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
                      });
                    },
                  ),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Selective Dünyasını Keşfedin",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.exit_to_app_rounded,
                  title: "Çıkış Yap",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.delete,
                  title: "Delete account",
                  titleStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
