import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chats/description.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:encrypt/encrypt.dart' as encryption;

class Chats extends StatefulWidget {
  const Chats({
    super.key,
    required this.name,
    required this.id,
    required this.userId,
    required this.updateLastSent,
  });
  final String name;
  final String id;
  final Function updateLastSent;
  final String? userId;
  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  List<dynamic> msgList = [];
  final TextEditingController _message = TextEditingController();
  late Socket socket;
  List<String> typer = [];
  @override
  void initState() {
    super.initState();

    _message.addListener(_printLatestValue);
    if (kIsWeb) {
      socket = io(
        "https://chat-nest.onrender.com",
        OptionBuilder().setExtraHeaders({'senderid': widget.userId}) // optional
            .build(),
      );
    } else {
      socket = io(
        "https://chat-nest.onrender.com",
        OptionBuilder().setTransports(['websocket']).setExtraHeaders(
                {'senderid': widget.userId}) // optional
            .build(),
      );
    }
    socket.emitWithAck("joinRoom", {"groupId": widget.id}, ack: (payload) {
      // print(payload);
    });

    socket.on("typing", (data) {
      if (data["isTyping"] == true) {
        if (!typer.contains(data["userId"])) {
          if (mounted) {
            setState(() {
              typer.add(data["userId"]);
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            typer.remove(data["userId"]);
          });
        }
      }
      // print(typer);
    });
    socket.emitWithAck(
        "fetchAllMessages", {"groupId": widget.id, "userId": widget.userId},
        ack: (payload) {
      //print(payload);
      setState(() {
        msgList = payload["allMessages"];
      });
    });
    socket.on("chatToClient", (data) {
      if (mounted) {
        setState(() {
          msgList.insert(0, data);

          widget.updateLastSent(data["groupId"], data["content"],
              data["createdAt"], data["msgRead"]);
        });
      }
    });
  }

  String realEnc(String message, String groupId) {
    final plainText = message;
    final key = encryption.Key.fromUtf8(groupId);
    final iv = encryption.IV.fromBase64("AAAAAAAAAAAAAAAAAAAAAA==");
    // print(plainText);
    // print(key);
    // print(iv.base64);
    final encrypter =
        encryption.Encrypter(encryption.AES(key, mode: encryption.AESMode.cbc));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  String realDec(String encryptedMessage, String groupId) {
    final key = encryption.Key.fromUtf8(groupId);
    final iv = encryption.IV.fromBase64("AAAAAAAAAAAAAAAAAAAAAA==");
    // print(encryptedMessage);
    // print(key.base64);
    // print(iv.base64);
    final encrypter =
        encryption.Encrypter(encryption.AES(key, mode: encryption.AESMode.cbc));
    final decrypted = encrypter
        .decrypt(encryption.Encrypted.from64(encryptedMessage), iv: iv);
    return decrypted;
  }

  @override
  void dispose() {
    if (mounted) {
      msgList.clear();
      typer.clear();
    }
    socket.emitWithAck("leaveRoom", {"groupId": widget.id}, ack: (payload) {
      print(payload);
      socket.on("left", (data) {});
    });
    socket.off("chatToClient");
    socket.off("chatToServer");
    socket.off("typing");
    socket.off("left");
    super.dispose();
  }

  void _printLatestValue() {
    // print('Second text field: ${_message.text} ');
    if (_message.text.isNotEmpty) {
      socket.emit(
        "typing",
        {"groupId": widget.id, "userId": widget.userId, "isTyping": true},
      );
    }
    Future.delayed(const Duration(seconds: 5), () {
      socket.emit(
        "typing",
        {"groupId": widget.id, "userId": widget.userId, "isTyping": false},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: ThemeColors.topTextColorLight,
        ),
        titleTextStyle: TextStyle(
          color: ThemeColors.topTextColorLight,
          fontSize: 18,
          fontFamily: ThemeColors.fontFamily,
        ),
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: const Tooltip(
                  message: "Back",
                  child: Icon(Icons.arrow_back_ios),
                ),
                onTap: () {
                  // socket.emitWithAck("leaveRoom", {"groupId": widget.id},
                  //     ack: (payload) {
                  //   // print(payload);
                  //   // print("payload");
                  // });
                  Navigator.of(context).pop();
                },
              ),
            ),
            const Gap(5),
            Hero(
              tag: widget.id,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Description(
                          id: widget.id,
                          name: widget.name,
                          uid: widget.userId,
                        ),
                      ),
                    );
                  },
                  radius: 22,
                  child: Container(
                    width: 44,
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ThemeColors.mainThemeLight,
                    ),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.transparent,
                      child: SvgPicture.string(
                        Jdenticon.toSvg(widget.id),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Description(
                          id: widget.id,
                          name: widget.name,
                          uid: widget.userId,
                        ),
                      ),
                    );
                  },
                  child: Tooltip(
                    message: widget.name,
                    child: Text(
                      widget.name,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: ThemeColors.fontFamily,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Tooltip(
              message: "Video Call",
              child: Icon(
                CupertinoIcons.videocam_fill,
                size: 30,
              ),
            ),
          ),
          Gap(5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Tooltip(
              message: "Phone",
              child: Icon(
                CupertinoIcons.phone_fill,
                size: 30,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.transparent,
          child: TextField(
            controller: _message,
            autocorrect: true,
            onSubmitted: (String value) {
              if (kIsWeb) {
                if (_message.text.trim().isNotEmpty) {
                  String encMessage = realEnc(_message.text.trim(), widget.id);
                  socket.emitWithAck(
                      "chatToServer",
                      {
                        "userId": widget.userId,
                        "groupId": widget.id,
                        "content": encMessage
                      },
                      ack: (payload) {});
                  _message.clear();
                }
              }
            },
            decoration: InputDecoration(
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ThemeColors.lighterShadeTextLight,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ThemeColors.lighterShadeTextLight,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
              fillColor: ThemeColors.mainThemeLight,
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ThemeColors.lighterShadeTextLight,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
              hintText: 'Write a message ...',
              hintStyle: TextStyle(
                color: ThemeColors.lighterShadeTextLight,
                fontFamily: ThemeColors.fontFamily,
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 10.0,
                ),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Tooltip(
                    message: "Add Files",
                    child: Icon(
                      CupertinoIcons.link,
                      color: ThemeColors.topTextColorLight,
                    ),
                  ),
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 6.0,
                ),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      if (_message.text.trim().isNotEmpty) {
                        String encMessage =
                            realEnc(_message.text.trim(), widget.id);
                        socket.emitWithAck(
                            "chatToServer",
                            {
                              "userId": widget.userId,
                              "groupId": widget.id,
                              "content": encMessage
                            },
                            ack: (payload) {});
                        _message.clear();
                      }
                    },
                    child: Tooltip(
                      message: "Send",
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: ThemeColors.topTextColorLight,
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                            left: 3.0,
                          ),
                          child: Icon(
                            Icons.send,
                            color: ThemeColors.mainThemeLight,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            cursorColor: ThemeColors.topTextColorLight,
            style: TextStyle(
              color: ThemeColors.topTextColorLight,
              fontSize: 16,
              fontFamily: ThemeColors.fontFamily,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: Column(
          children: <Widget>[
            ...msgList
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: (e["user"]["id"] == widget.userId)
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        (e["user"]["id"] != widget.userId)
                            ? Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ThemeColors.profileImageBg,
                                ),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.transparent,
                                  child: SvgPicture.string(
                                    Jdenticon.toSvg(e["user"]["id"]),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        const Gap(10),
                        (e["user"]["id"] != widget.userId)
                            ? Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: size.width * 0.1,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: const BoxDecoration(
                                          color:
                                              ThemeColors.lighterShadeTextLight,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              e["user"]["username"],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily:
                                                    ThemeColors.fontFamily,
                                              ),
                                            ),
                                            const Gap(10),
                                            SelectableText(
                                              realDec(e["content"], widget.id),
                                              style: TextStyle(
                                                color:
                                                    ThemeColors.mainThemeLight,
                                                fontSize:
                                                    ThemeColors.chatFontSize,
                                                height: 1.4,
                                                fontFamily:
                                                    ThemeColors.fontFamily,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        DateFormat("dd-MM-yyyy")
                                            .add_jm()
                                            .format(
                                              DateTime.parse(
                                                e["createdAt"],
                                              ).toLocal(),
                                            ),
                                        style: TextStyle(
                                          color: ThemeColors.mainThemeLight,
                                          fontSize: 12,
                                          fontFamily: ThemeColors.fontFamily,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.1,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: const BoxDecoration(
                                          color: ThemeColors.mainThemeLight,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                        ),
                                        child: SelectableText(
                                          realDec(e["content"], widget.id),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: ThemeColors.oppositeTextBox,
                                            fontSize: ThemeColors.chatFontSize,
                                            height: 1.5,
                                            fontFamily: ThemeColors.fontFamily,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        DateFormat("dd-MM-yyyy")
                                            .add_jm()
                                            .format(
                                              DateTime.parse(
                                                e["createdAt"],
                                              ).toLocal(),
                                            ),
                                        style: TextStyle(
                                          color: ThemeColors.mainThemeLight,
                                          fontSize: 12,
                                          fontFamily: ThemeColors.fontFamily,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                )
                .toList()
                .reversed,
            Align(
              alignment: Alignment.topLeft,
              child: AnimatedContainer(
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
                width: (typer.isNotEmpty) ? size.width : 0,
                height: (typer.isNotEmpty) ? 70 : 0,
                child: Row(
                  children: <Widget>[
                    (typer.isNotEmpty)
                        ? Expanded(
                            child: Stack(
                              children: <Widget>[
                                ...typer
                                    .map(
                                      (e) => Positioned(
                                        left: typer.indexOf(e) * 15.0,
                                        top: 10,
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ThemeColors.profileImageBg,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                blurRadius: 5.0,
                                                offset: Offset(0.0, 3.0),
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: Colors.transparent,
                                            child: SvgPicture.string(
                                              Jdenticon.toSvg(e),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                Positioned(
                                  // left: typer.length * 35 +
                                  //     ((typer.length == 1) ? 20 : 0),
                                  left: typer.length *
                                      ((typer.length == 1) ? 60 : 40),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: const BoxDecoration(
                                      color: ThemeColors
                                          .lighterShadeTextLightForShadow,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          blurRadius: 4.0,
                                          offset: Offset(0.0, 3.0),
                                          color: Colors.grey,
                                        )
                                      ],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: const JumpingDots(
                                      color: ThemeColors.mainThemeLight,
                                      radius: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            const Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.profileImageBg,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    shape: BoxShape.rectangle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 35.0,
                        offset: const Offset(-18.0, 1.0),
                        color: Colors.grey.shade400,
                      )
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(5, 11, 3, 11),
                  child: const Icon(
                    Icons.lock,
                    size: 12,
                    color: ThemeColors.mainThemeLight,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.profileImageBg,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    shape: BoxShape.rectangle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 35.0,
                        offset: const Offset(20.0, 1.0),
                        color: Colors.grey.shade400,
                      )
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(3, 10, 5, 10),
                  child: Text(
                    "End-to-End Encrypted",
                    style: TextStyle(
                      color: ThemeColors.mainThemeLight,
                      fontSize: 12,
                      fontFamily: ThemeColors.fontFamily,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
