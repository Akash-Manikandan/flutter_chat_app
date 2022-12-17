import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';

class Charts extends StatelessWidget {
  Charts({super.key, required this.name, required this.id});
  final String name;
  final String id;
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
      "time": "11:47 PM",
      "count": 4,
    }
  ];
  final myId = "Akash";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeColors.lighterShadeTextLight,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: ThemeColors.topTextColorLight,
        ),
        titleTextStyle: const TextStyle(
          color: ThemeColors.topTextColorLight,
          fontSize: 18,
        ),
        leadingWidth: 45,
        title: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ThemeColors.profileImageBgChatPage,
              ),
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.transparent,
                child: SvgPicture.string(
                  Jdenticon.toSvg(id),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Gap(12),
            Text(name),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              ...userList
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: (e["id"] == myId)
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
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
                              : const SizedBox(),
                          const Gap(10),
                          (e["id"] != myId)
                              ? Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: size.width * 0.1,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: const BoxDecoration(
                                            color: ThemeColors.oppositeTextBox,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Text(
                                            e["message"],
                                            style: const TextStyle(
                                              color: ThemeColors.mainThemeLight,
                                              fontSize: 16,
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
                              : Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
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
                                          child: Text(
                                            e["message"],
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                              color:
                                                  ThemeColors.oppositeTextBox,
                                              fontSize: 16,
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
      ),
    );
  }
}
