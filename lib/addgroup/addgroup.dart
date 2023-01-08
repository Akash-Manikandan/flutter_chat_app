import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/addgroup/userlistwithouthero.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:gap/gap.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../main.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({super.key});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  String stringValue = "";
  Future<dynamic> fetchAlbum() async {
    // dynamic data = null;
    final response = await http.get(
      Uri.parse(
          "https://nestchatbackend-production.up.railway.app/user/fetchAllUsers"),
    );
    // if (response.statusCode == 200) {
    //   setState(() {});
    // } else {
    //   throw Exception('Failed to load statistics');
    // }
    if (response.statusCode == 200) {
      setState(() {
        userList = jsonDecode(response.body);
      });
    }
    // print(data);
    // return data;
  }

  Set<String> list = {};
  List<dynamic> userList = [];
  void addValue(String id) {
    setState(() {
      list.add(id);
    });
  }

  void removeValue(String id) {
    setState(() {
      list.remove(id);
    });
  }

  late IO.Socket socket;
  @override
  void initState() {
    initSocket();
    super.initState();

    fetchAlbum();
  }

  initSocket() {
    if (kIsWeb) {
      socket = IO.io(
        "https://nestchatbackend-production.up.railway.app",
        IO.OptionBuilder()
            .setExtraHeaders({'senderid': stringValue}) // optional
            .build(),
      );
    } else {
      socket = IO.io(
        "https://nestchatbackend-production.up.railway.app",
        IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders(
                {'senderid': stringValue}) // optional
            .build(),
      );
    }

    socket.connect();
    socket.onConnect((_) {
      //print(socket.connected);
      print('Connection established');
    });

    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    stringValue = prefs.getString('userId')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: const Icon(Icons.arrow_back_ios),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            const Gap(10),
            const Text("Add Group"),
          ],
        ),
        iconTheme: const IconThemeData(
          color: ThemeColors.topTextColorLight,
        ),
        titleTextStyle: const TextStyle(
          color: ThemeColors.topTextColorLight,
          fontSize: 20,
        ),
        actions: [
          (list.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.only(
                    right: 12.0,
                  ),
                  child: IconButton(
                    onPressed: () async {
                      await getStringValuesSF();
                      // print(
                      //   list.add(stringValue),
                      // );
                      // print(list);
                      // list.toList();
                      // print(list.toList());
                      socket.emitWithAck('createGroup', {
                        "userIds": list.toList(),
                        "grpName": "sampledfefefeGrpefdffg"
                      }, ack: (data) {
                        print(data);

                        Navigator.pop(context, true);
                      });
                    },
                    tooltip: "Add new group",
                    icon: const Icon(
                      CupertinoIcons.add_circled,
                      size: 32,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...userList.map(
              (each) {
                return UserListWithoutHero(
                  name: each["username"],
                  id: each["id"],
                  lastMsg: "",
                  time: DateFormat.jm().format(
                    DateTime.parse(
                      each["createdAt"],
                    ).toLocal(),
                  ),
                  count: 0,
                  listAdd: addValue,
                  listRemove: removeValue,
                  lcount: list.length,
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
