import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chats/chats.dart';
import 'package:flutter_chat_app/homepage/userlist.dart';

import 'package:flutter_chat_app/themecolors.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.isClicked});
  final bool isClicked;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> userList = [
    {
      "id": "Karthi",
      "name": "Karthi",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Aishwarya",
      "name": "Aishwarya",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "Akash",
      "name": "Akash",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    }
  ];

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
              const Padding(
                padding: EdgeInsets.only(
                  left: 6.0,
                  top: 6.0,
                ),
                child: Text(
                  "Chats",
                  style: TextStyle(
                    color: ThemeColors.topTextColorLight,
                    fontSize: 24,
                  ),
                ),
              ),
              const Gap(20),
              TextField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  enabled: !widget.isClicked,
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
                    fontSize: 16,
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
                cursorHeight: 26,
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
            clipBehavior: Clip.antiAlias,
            physics: ScrollPhysics(
              parent: !widget.isClicked
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
            ),
            child: Column(
              children: <Widget>[
                const Gap(10),
                ...userList
                    .map(
                      (each) => MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: !widget.isClicked
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Charts(
                                        name: each["name"],
                                        id: each["id"],
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          child: UserList(
                            id: each["id"],
                            name: each["name"],
                            lastMsg: each["lastMsg"],
                            time: each["time"],
                            count: each["count"],
                          ),
                        ),
                      ),
                    )
                    .toList()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
