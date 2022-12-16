import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/homepage/userlist.dart';

import 'package:flutter_chat_app/themecolors.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          width: size.width,
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
            color: ThemeColors.mainThemeLight,
            backgroundBlendMode: BlendMode.multiply,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Chats",
                style: TextStyle(
                  color: ThemeColors.topTextColorLight,
                  fontSize: 24,
                ),
              ),
              const Gap(20),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: ThemeColors.lighterShadeTextLight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: ThemeColors.lighterShadeTextLight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  fillColor: ThemeColors.mainThemeLight,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: ThemeColors.lighterShadeTextLight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  hintText: 'Search chat, people and more...',
                  hintStyle: const TextStyle(
                    color: ThemeColors.lighterShadeTextLight,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 8.0,
                    ),
                    child: Icon(
                      CupertinoIcons.search,
                      color: ThemeColors.topTextColorLight,
                    ),
                  ),
                ),
                cursorColor: ThemeColors.topTextColorLight,
                style: const TextStyle(
                  color: ThemeColors.topTextColorLight,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Gap(10),
                UserList(
                  id: "Karthi",
                  name: "Karthi",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Aishwarya",
                  name: "Aishwarya",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Akash",
                  name: "Akash",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Karthi",
                  name: "Karthi",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Aishwarya",
                  name: "Aishwarya",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Akash",
                  name: "Akash",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Karthi",
                  name: "Karthi",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Aishwarya",
                  name: "Aishwarya",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Akash",
                  name: "Akash",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Karthi",
                  name: "Karthi",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Aishwarya",
                  name: "Aishwarya",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Akash",
                  name: "Akash",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Karthi",
                  name: "Karthi",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Aishwarya",
                  name: "Aishwarya",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Akash",
                  name: "Akash",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Karthi",
                  name: "Karthi",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Aishwarya",
                  name: "Aishwarya",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
                UserList(
                  id: "Akash",
                  name: "Akash",
                  lastMsg: "Hello, Good Morning",
                  time: "11:47 PM",
                  count: 4,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
