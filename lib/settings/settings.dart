import 'package:flutter/material.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void savePreference(String family) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fontFamily", family);
  }

  String fontFam = ThemeColors.fontFamily;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "What font you want?",
              style: TextStyle(
                fontSize: 18,
                fontFamily: ThemeColors.fontFamily,
              ),
            ),
            const Divider(),
            RadioListTile(
              title: const Text("Nexa"),
              value: "Nexa",
              groupValue: fontFam,
              onChanged: (value) {
                setState(() {
                  fontFam = value.toString();
                  ThemeColors.fontFamily = fontFam;
                  savePreference(fontFam);
                });
              },
            ),
            RadioListTile(
              title: Text(
                "Montserrat",
                style: TextStyle(
                  fontFamily: ThemeColors.fontFamily,
                ),
              ),
              value: "Montserrat",
              groupValue: fontFam,
              onChanged: (value) {
                setState(() {
                  fontFam = value.toString();
                  ThemeColors.fontFamily = fontFam;
                  savePreference(fontFam);
                });
              },
            ),
            RadioListTile(
              title: Text(
                "Poppins",
                style: TextStyle(
                  fontFamily: ThemeColors.fontFamily,
                ),
              ),
              value: "Poppins",
              groupValue: fontFam,
              onChanged: (value) {
                setState(() {
                  fontFam = value.toString();
                  ThemeColors.fontFamily = fontFam;
                  savePreference(fontFam);
                });
              },
            ),
            RadioListTile(
              title: Text(
                "Soban",
                style: TextStyle(
                  fontFamily: ThemeColors.fontFamily,
                ),
              ),
              value: "Soban",
              groupValue: fontFam,
              onChanged: (value) {
                setState(() {
                  fontFam = value.toString();
                  ThemeColors.fontFamily = fontFam;
                  savePreference(fontFam);
                });
              },
            ),
            RadioListTile(
              title: Text(
                "Fredoka",
                style: TextStyle(
                  fontFamily: ThemeColors.fontFamily,
                ),
              ),
              value: "Fredoka",
              groupValue: fontFam,
              onChanged: (value) {
                setState(() {
                  fontFam = value.toString();
                  ThemeColors.fontFamily = fontFam;
                  savePreference(fontFam);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
