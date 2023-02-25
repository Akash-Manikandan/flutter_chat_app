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
  });
  final bool isClicked;
  final Function onAuthStateChange;
  final Function closeNavigation;

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
    super.initState();
    initSocket();
  }

  initSocket() async {
    await getStringValuesSF();
    if (kIsWeb) {
      socket = IO.io(
        "https://chat-nest.onrender.com",
        IO.OptionBuilder().setExtraHeaders({'senderid': userD}) // optional
            .build(),
      );
    } else {
      socket = IO.io(
        "https://chat-nest.onrender.com",
        IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders(
                {'senderid': userD}) // optional
            .build(),
      );
    }

    socket.connect();
    socket.onConnect((_) async {
      //print(socket.connected);
      if (mounted) {
        print('Connection established');
        socket.emitWithAck('fetchAllGroups', {"userId": userD}, ack: (data) {
          setState(() {
            userList = data;
          });
        });
      }
    });
    // socket.emitWithAck('fetchAllGroups', {"userId": widget.userId},
    //     ack: (data) {
    //   // print(data);
    //   setState(() {
    //     userList = data;
    //   });
    // });
    socket.on('exception', (data) {
      print(data);
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }

  updateLastSent(String grpId, String msg, String time, bool read) {
    int index = userList.indexWhere((user) => user["id"] == grpId);
    if (index != -1) {
      if (userList[index]["messages"].length > 0) {
        setState(() {
          userList[index]["messages"][0]["createdAt"] = time;
          userList[index]["messages"][0]["content"] = msg;
          userList[index]["messages"][0]["msgRead"] = read;
        });
      } else {
        setState(() {
          userList[index]["messages"] = [
            {
              "createdAt": time,
              "content": msg,
              "msgRead": read,
              "groupId": grpId,
            }
          ];
        });
      }
    }
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
                                      builder: (context) => Chats(
                                        name: each["groupName"],
                                        id: each["id"],
                                        userId: userD,
                                        updateLastSent: updateLastSent,
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