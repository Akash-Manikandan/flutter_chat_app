import 'package:flutter/material.dart';
import 'package:flutter_chat_app/themecolors.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String gender = ThemeColors.fontFamily;
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
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                  ThemeColors.fontFamily = gender;
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
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                  ThemeColors.fontFamily = gender;
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
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                  ThemeColors.fontFamily = gender;
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
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                  ThemeColors.fontFamily = gender;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
