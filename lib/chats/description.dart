import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chats/userlistdesc.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:readmore/readmore.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Description extends StatefulWidget {
  const Description(
      {super.key, required this.id, required this.name, required this.uid});
  final String id;
  final String name;
  final String? uid;
  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  late IO.Socket socket;
  late dynamic descVal = "";
  bool descIsNull = true;
  bool isEdit = false;
  bool isSubmit = false;
  @override
  void initState() {
    initSocket();
    super.initState();
    descController.text = descVal;
  }

  initSocket() {
    if (kIsWeb) {
      socket = IO.io(
        "https://nestchatbackend-production.up.railway.app",
        IO.OptionBuilder().setExtraHeaders({'senderid': widget.uid}) // optional
            .build(),
      );
    } else {
      socket = IO.io(
        "https://nestchatbackend-production.up.railway.app",
        IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders(
                {'senderid': widget.uid}) // optional
            .build(),
      );
    }

    socket.connect();
    socket.onConnect((_) {
      //print(socket.connected);
      print('Connection established');
    });
    socket.emitWithAck('fetchUsers', {"groupId": widget.id}, ack: (data) {
      // print(data);
      setState(() {
        userList = data["user"];
      });
    });
    socket.emitWithAck('updateGroupDesc', {"groupId": widget.id}, ack: (data) {
      // print(data);
      setState(() {
        descVal = data["description"];
        // print(descVal);
        if (descVal != null) {
          descIsNull = false;
          // print(descIsNull);
        }
      });
    });

    // socket.on('updateGroupDesc', (args:any) => {});
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }

  List<dynamic> userList = [];
  // {
  //   "id": "Karthi",
  //   "name": "Karthi",
  //   "message": "Hello, Good Morning",
  //   "time": "11:47 PM",
  //   "count": 4,
  // },
  // {
  //   "id": "Aishwarya",
  //   "name": "Aishwarya",
  //   "message": "Hello, Morning",
  //   "time": "11:47 PM",
  //   "count": 7,
  // },
  // {
  //   "id": "Akash",
  //   "name": "Akash",
  //   "message": "Bye",
  //   "time": "11:47 PM",
  //   "count": 4,
  // },
  // ];

  TextEditingController descController = TextEditingController();

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
                    color: ThemeColors.mainThemeLight,
                    child: Hero(
                      tag: widget.id,
                      child: SvgPicture.string(
                        Jdenticon.toSvg(widget.id),
                        width: size.width,
                        height: size.height * 0.4,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 00,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                      ),
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: ThemeColors.fontFamily,
                          color: ThemeColors.topTextColorLight,
                        ),
                      ),
                    ),
                  ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: ThemeColors.fontFamily,
                            ),
                          ),
                          (descIsNull)
                              ? (!isSubmit)
                                  ? IconButton(
                                      tooltip: "Add Description",
                                      icon: const Icon(CupertinoIcons.plus_app),
                                      onPressed: () {
                                        setState(() {
                                          isEdit = !isEdit;
                                          isSubmit = !isSubmit;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      tooltip: "Submit",
                                      icon: const Icon(
                                          CupertinoIcons.checkmark_alt_circle),
                                      onPressed: () {
                                        isSubmit = false;
                                        isEdit = !isEdit;
                                        descIsNull = !descIsNull;
                                        setState(() {
                                          socket.emitWithAck(
                                              'updateGroupDesc', {
                                            "groupId": widget.id,
                                            "newGroupDesc": descVal
                                          }, ack: (data) {
                                            // print(data);
                                            setState(() {
                                              descVal = data["description"];
                                            });
                                          });
                                          socket.on('exception', (data) {
                                            print(data);
                                          });
                                          // print("editing");
                                        });
                                      },
                                    )
                              : (!isEdit && !isSubmit)
                                  ? IconButton(
                                      tooltip: "Edit Description",
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        setState(() {
                                          isEdit = !isEdit;
                                          isSubmit = true;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      tooltip: "Submit",
                                      icon: const Icon(
                                          CupertinoIcons.checkmark_alt_circle),
                                      onPressed: () {
                                        isSubmit = false;
                                        isEdit = !isEdit;

                                        setState(() {
                                          socket.emitWithAck(
                                              'updateGroupDesc', {
                                            "groupId": widget.id,
                                            "newGroupDesc": descVal
                                          }, ack: (data) {
                                            // print(data);
                                            setState(() {
                                              descVal = data["description"];
                                            });
                                          });
                                          socket.on('exception', (data) {
                                            print(data);
                                          });
                                          // print("editing");
                                        });
                                      },
                                    )
                        ],
                      ),
                      const Gap(20),
                      (isEdit)
                          ? TextField(
                              autofocus: true,
                              maxLength: 35,
                              controller: descController,
                              style: const TextStyle(
                                color: ThemeColors.topTextColorLight,
                              ),
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ThemeColors.mainThemeLight,
                                  ),
                                ),
                              ),
                              onChanged: (text) => {
                                setState(() => {descVal = text})
                              },
                            )
                          : (!descIsNull)
                              ? ReadMoreText(
                                  descVal,
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
                                )
                              : Gap(2),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: <Widget>[
                      ...userList
                          .map(
                            (each) => UserListDesc(
                              id: each["id"],
                              name: each["username"],
                              lastMsg: "",
                              time: "",
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
