import 'package:flutter/material.dart';
import 'package:flutter_chat_app/devinfo/dev.dart';
import 'package:gap/gap.dart';
import 'package:flutter_chat_app/themecolors.dart';

class DevInfo extends StatefulWidget {
  const DevInfo({super.key});

  @override
  State<DevInfo> createState() => _DevInfoState();
}

class _DevInfoState extends State<DevInfo> {
  List<dynamic> developers = [
    {
      "name": "Aishwarya S",
      "icon": "iconLink",
      "role": "Backend Developer",
      "mail": "smt@gmail.com",
      "github": "gh",
      "linkedIn": "li",
    },
    {
      "name": "Akash M",
      "icon": "iconLink",
      "role": "Frontend Developer",
      "mail": "smt@gmail.com",
      "github": "gh",
      "linkedIn": "li",
    },
    {
      "name": "Karthikeyan E",
      "icon": "iconLink",
      "role": "Backend Developer",
      "mail": "smt@gmail.com",
      "github": "gh",
      "linkedIn": "li",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: const Icon(Icons.arrow_back_ios),
                onTap: () => Navigator.pop(context, true),
              ),
            ),
            const Gap(10),
            const Flexible(
              child: Text(
                'Developers\' Information',
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(
          color: ThemeColors.topTextColorLight,
        ),
        titleTextStyle: const TextStyle(
          color: ThemeColors.topTextColorLight,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...developers.map(
              (item) {
                return Dev(
                  name: item["name"],
                  icon: item["icon"],
                  role: item["role"],
                  mail: item["mail"],
                  github: item["github"],
                  linkedIn: item["linkedIn"],
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
