import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chats/description.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';

class Charts extends StatefulWidget {
  const Charts({super.key, required this.name, required this.id});
  final String name;
  final String id;

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  final List<Map<String, dynamic>> userList = [
    {
      "id": "Karthi",
      "name": "Karthi",
      "message": "Hello, Good Morning cdkbfkhifodigoiGFIODGUIGFUIVG",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Aishwarya",
      "name": "Aishwarya",
      "message": "Hello, Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "Akash",
      "name": "Akash",
      "message": "Bye",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Karthi",
      "name": "Karthi",
      "message": "Hello, Good Morning cdkbfkhifodigoiGFIODGUIGFUIVG",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Aishwarya",
      "name": "Aishwarya",
      "message": "Hello, Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "Akash",
      "name": "Akash",
      "message": "Bye",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Karthi",
      "name": "Karthi",
      "message": "Hello, Good Morning cdkbfkhifodigoiGFIODGUIGFUIVG",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Aishwarya",
      "name": "Aishwarya",
      "message": "Hello, Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "Akash",
      "name": "Akash",
      "message": "Bye",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Karthi",
      "name": "Karthi",
      "message": "Hello, Good Morning cdkbfkhifodigoiGFIODGUIGFUIVG",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Aishwarya",
      "name": "Aishwarya",
      "message": "Hello, Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "Akash",
      "name": "Akash",
      "message": "Bye",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Karthi",
      "name": "Karthi",
      "message": "Hello, Good Morning cdkbfkhifodigoiGFIODGUIGFUIVG",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Aishwarya",
      "name": "Aishwarya",
      "message": "Hello, Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "Akash",
      "name": "Akash",
      "message":
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Karthi",
      "name": "Karthi",
      "message": "Hello, Good Morning cdkbfkhifodigoiGFIODGUIGFUIVG",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Aishwarya",
      "name": "Aishwarya",
      "message":
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "Akash",
      "name": "Akash",
      "message": "Bye",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Karthi",
      "name": "Karthi",
      "message":
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, ",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Aishwarya",
      "name": "Aishwarya",
      "message": "Hello, Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "Akash",
      "name": "Akash",
      "message": "Bye",
      "time": "10:47 PM",
      "count": 4,
    }
  ];

  final myId = "Aishwarya";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: ThemeColors.topTextColorLight,
        ),
        titleTextStyle: const TextStyle(
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
                child: const Icon(Icons.arrow_back_ios),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            const Gap(5),
            Row(
              children: [
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
                          color: ThemeColors.profileImageBgChatPage,
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
                Text(widget.name),
              ],
            ),
          ],
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              CupertinoIcons.videocam_fill,
              size: 30,
            ),
          ),
          Gap(5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              CupertinoIcons.phone_fill,
              size: 30,
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
              hintStyle: const TextStyle(
                color: ThemeColors.lighterShadeTextLight,
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  right: 10.0,
                ),
                child: Icon(
                  CupertinoIcons.link,
                  color: ThemeColors.topTextColorLight,
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 6.0,
                ),
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
            cursorColor: ThemeColors.topTextColorLight,
            style: const TextStyle(
              color: ThemeColors.topTextColorLight,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: Column(
          children: <Widget>[
            ...userList
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: (e["id"] == myId)
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        (e["id"] != myId)
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
                                    Jdenticon.toSvg(e["id"]),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        const Gap(10),
                        (e["id"] != myId)
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
                                              e["name"],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Gap(10),
                                            SelectableText(
                                              e["message"],
                                              style: const TextStyle(
                                                color:
                                                    ThemeColors.mainThemeLight,
                                                fontSize:
                                                    ThemeColors.chatFontSize,
                                                height: 1.4,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        e["time"],
                                        style: const TextStyle(
                                          color: ThemeColors.mainThemeLight,
                                          fontSize: 12,
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
                                          e["message"],
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            color: ThemeColors.oppositeTextBox,
                                            fontSize: ThemeColors.chatFontSize,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        e["time"],
                                        style: const TextStyle(
                                          color: ThemeColors.mainThemeLight,
                                          fontSize: 12,
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
                .toList(),
          ],
        ),
      ),
    );
  }
}
