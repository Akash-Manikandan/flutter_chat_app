import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chats/chats.dart';
import 'package:flutter_chat_app/homepage/userlist.dart';

import 'package:flutter_chat_app/themecolors.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.isClicked,
    required this.onAuthStateChange,
  });
  final bool isClicked;
  final Function onAuthStateChange;
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
    },
    {
      "id": "S1",
      "name": "S1",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "S2",
      "name": "S2",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "S3",
      "name": "S3",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "S4",
      "name": "S4",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "S5",
      "name": "S5",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "S6",
      "name": "S6",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "S7",
      "name": "S7",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "S8",
      "name": "S8",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "S9",
      "name": "S9",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "S10",
      "name": "S10",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "S11",
      "name": "S11",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "S12",
      "name": "S12",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    }
  ];
  bool oneselected = false;

  void onChange() {
    setState(() {
      oneselected = !oneselected;
    });
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("userDetails");
  }

  String? userD;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userD = prefs.getString('userId');
    if (userD != null) {
    } else {
      widget.onAuthStateChange(false);
    }
  }

  late IO.Socket socket;
  @override
  initState() {
    getStringValuesSF();
    initSocket();
    super.initState();
  }

  initSocket() {
    socket = IO.io(
      "https://nestchatbackend-production.up.railway.app",
      IO.OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM

          .setExtraHeaders({'senderid': userD}) // optional
          .build(),
    );
    socket.connect();
    socket.onConnect((_) {
      print(socket.connected);
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }

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
              Padding(
                padding: const EdgeInsets.only(
                  left: 6.0,
                  top: 6.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chats",
                      style: TextStyle(
                        color: ThemeColors.topTextColorLight,
                        fontSize: 24,
                        fontFamily: ThemeColors.fontFamily,
                      ),
                    ),
                    Tooltip(
                      message: "Logout",
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            await removeValues();
                            widget.onAuthStateChange(false);
                          },
                          child: const SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.logout_outlined,
                              color: ThemeColors.topTextColorLight,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Gap(20),
              TextField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
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
                  hintMaxLines: 1,
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
                      size: 30,
                    ),
                  ),
                ),
                cursorColor: ThemeColors.topTextColorLight,
                cursorHeight: 26,
                style: TextStyle(
                  color: ThemeColors.topTextColorLight,
                  fontSize: 16,
                  fontFamily: ThemeColors.fontFamily,
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
                ...userList
                    .map(
                      (each) => MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          behavior: !widget.isClicked
                              ? HitTestBehavior.translucent
                              : HitTestBehavior.deferToChild,
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
                              : () {},
                          child: UserList(
                            id: each["id"],
                            name: each["name"],
                            lastMsg: each["lastMsg"],
                            time: each["time"],
                            count: each["count"],
                            onChange: onChange,
                            oneselected: oneselected,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                const Gap(80),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
