import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chats/chats.dart';
import 'package:flutter_chat_app/homepage/userlist.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:readmore/readmore.dart';

class Description extends StatefulWidget {
  const Description({super.key, required this.id});
  final String id;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  List<Map<String, dynamic>> userList = [
    {
      "id": "Karthi",
      "name": "Karthi",
      "message": "Hello, Good Morning",
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
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            iconTheme: const IconThemeData(
              color: ThemeColors.topTextColorLight,
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ThemeColors.mainThemeLight,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.only(left: 8.0),
                    child: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: ThemeColors.mainThemeLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.search,
                    size: 30,
                  ),
                ),
              ),
              const Gap(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: ThemeColors.mainThemeLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.qrcode,
                    size: 30,
                  ),
                ),
              )
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            expandedHeight: size.height * 0.4 + 30,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: <Widget>[
                  Container(
                    width: size.width,
                    height: size.height * 0.5,
                    color: ThemeColors.profileImageBgLightestVersion,
                    child: Hero(
                      tag: widget.id,
                      child: SvgPicture.string(
                        Jdenticon.toSvg(widget.id),
                        width: size.width,
                        height: size.height * 0.45,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                      ),
                      child: Text(
                        widget.id,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: ThemeColors.fontFamily,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: ThemeColors.fontFamily,
                        ),
                      ),
                      const Gap(20),
                      ReadMoreText(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit",
                        trimLines: 3,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: "Read more",
                        trimExpandedText: "...Show less",
                        moreStyle: const TextStyle(
                          color: ThemeColors.topTextColorLight,
                        ),
                        lessStyle: const TextStyle(
                          color: ThemeColors.topTextColorLight,
                        ),
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: ThemeColors.fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      ...userList
                          .map(
                            (each) => MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Charts(
                                        name: each["name"],
                                        id: each["id"] + "id",
                                      ),
                                    ),
                                  );
                                },
                                child: UserList(
                                  id: each["id"] + "id",
                                  name: each["name"],
                                  lastMsg: each["message"],
                                  time: each["time"],
                                  count: each["count"],
                                ),
                              ),
                            ),
                          )
                          .toList()
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
