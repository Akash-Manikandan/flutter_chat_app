import 'package:flutter/material.dart';
import 'package:flutter_chat_app/devinfo/dev.dart';
import 'package:gap/gap.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'dart:math';

class DevInfo extends StatefulWidget {
  const DevInfo({super.key});

  @override
  State<DevInfo> createState() => _DevInfoState();
}

class _DevInfoState extends State<DevInfo> {
  void initState() {
    // print(developers[item]);
  }

  List<dynamic> developers = [
    {
      "name": "Akash M",
      "iconsList": [
        "https://api.dicebear.com/5.x/avataaars/png?seed=Akashh&eyebrows=defaultNatural&eyes=default,happy&facialHairProbability=5&mouth=default,smile",
        "https://api.dicebear.com/5.x/avataaars/png?seed=Mimi&eyebrows=defaultNatural&eyes=default,happy&mouth=default,smile",
        "https://api.dicebear.com/5.x/avataaars/png?seed=Mim&eyebrows=defaultNatural&eyes=default,happy&mouth=default,smile"
      ],
      "role": "Frontend Developer",
      "mail": "smt@gmail.com",
      "github": "gh",
      "linkedIn": "li",
    },
    {
      "name": "Aishwarya S",
      "iconsList": [
        "https://api.dicebear.com/5.x/avataaars/png?seed=Ka&eyebrows=defaultNatural&eyes=default,happy&mouth=default,smile",
        "https://api.dicebear.com/5.x/avataaars/png?seed=Karthik&eyebrows=defaultNatural&eyes=default,happy&mouth=default,smile",
        "https://api.dicebear.com/5.x/avataaars/png?seed=Aish&eyebrows=flatNatural,defaultNatural&eyes=default,happy&facialHairProbability=5&mouth=default,smile"
      ],
      "role": "Backend Developer",
      "mail": "smt@gmail.com",
      "github": "gh",
      "linkedIn": "li",
    },
    {
      "name": "Karthikeyan E",
      "iconsList": [
        "https://api.dicebear.com/5.x/avataaars/png?seed=Karth&eyebrows=defaultNatural&eyes=default,happy&mouth=default,smile",
        "https://api.dicebear.com/5.x/avataaars/png?seed=Pumpkin&eyebrows=defaultNatural&eyes=default,happy&mouth=default,smile",
        "https://api.dicebear.com/5.x/avataaars/png?seed=Karthikeyan&eyebrows=defaultNatural&eyes=default,happy&mouth=default,smile"
      ],
      "role": "Backend Developer",
      "mail": "smt@gmail.com",
      "github": "gh",
      "linkedIn": "li",
    },
  ];
  int randomNumber = Random().nextInt(2);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
            Flexible(
              child: Text(
                'Developers\' Information',
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: ThemeColors.fontFamily,
                ),
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
                  icon: item["iconsList"][randomNumber],
                  role: item["role"],
                  mail: item["mail"],
                  github: item["github"],
                  linkedIn: item["linkedIn"],
                  left: developers.indexOf(item) % 2,
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
