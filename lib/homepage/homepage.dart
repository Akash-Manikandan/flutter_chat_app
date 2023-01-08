import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chats/chats.dart';
import 'package:flutter_chat_app/homepage/userlist.dart';

import 'package:flutter_chat_app/themecolors.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.isClicked,
    required this.onAuthStateChange,
    required this.closeNavigation,
    required this.userId,
  });
  final bool isClicked;
  final Function onAuthStateChange;
  final Function closeNavigation;
  final String? userId;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> userList = [];
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
    prefs.remove('userId');
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
    initSocket();
    super.initState();
  }

  initSocket() {
    if (kIsWeb) {
      socket = IO.io(
        "https://nestchatbackend-production.up.railway.app",
        IO.OptionBuilder()
            .setExtraHeaders({'senderid': widget.userId}) // optional
            .build(),
      );
    } else {
      socket = IO.io(
        "https://nestchatbackend-production.up.railway.app",
        IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders(
                {'senderid': widget.userId}) // optional
            .build(),
      );
    }

    socket.connect();
    socket.onConnect((_) {
      //print(socket.connected);
      print('Connection established');
    });
    socket.emitWithAck('fetchAllGroups', {"userId": widget.userId},
        ack: (data) {
      // print(data);
      setState(() {
        userList = data;
      });
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
                padding: const EdgeInsets.fromLTRB(6, 6, 6, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Chats",
                      style: TextStyle(
                        color: ThemeColors.topTextColorLight,
                        fontSize: 24,
                        fontFamily: ThemeColors.fontFamily,
                      ),
                    ),
                    IconButton(
                      iconSize: 30,
                      splashRadius: 30,
                      tooltip: "Logout",
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: ThemeColors.topTextColorLight,
                      ),
                      onPressed: () async {
                        await removeValues();
                        socket.disconnect();
                        widget.onAuthStateChange(false);
                      },
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
                                        name: each["groupName"],
                                        id: each["id"],
                                        userId: widget.userId,
                                      ),
                                    ),
                                  );
                                }
                              : () {
                                  widget.closeNavigation();
                                },
                          child: UserList(
                            id: each["id"],
                            name: each["groupName"],
                            lastMsg: (each["messages"].length != 0)
                                ? each["messages"][0]["content"]
                                : "",
                            time: (each["messages"].length != 0)
                                ? DateFormat.jm().format(
                                    DateTime.parse(
                                      each["messages"][0]["createdAt"],
                                    ).toLocal(),
                                  )
                                : "",
                            count: 0,
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
/* 
DateFormat.jm().format(DateTime.parse(e["createdAt"],).toLocal(),)

*/