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
import 'package:animated_snack_bar/animated_snack_bar.dart';

class Description extends StatefulWidget {
  const Description({
    super.key,
    required this.id,
    required this.name,
    required this.uid,
  });
  final String id;
  final String name;
  final String? uid;
  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
// final productId = ModalRoute.of(context)!.settings.arguments == null
//       ? "NULL"
//       : ModalRoute.of(context)!.settings.arguments as String;

  late IO.Socket socket;
  late dynamic descVal;
  bool descIsNull = true;
  bool isEdit = false;
  bool isSubmit = false;
  String errorMsg = "Description cannot be null";
  late ScrollController _scrollController;
  @override
  void initState() {
    initSocket();
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(scrollListener);
  }

  bool checkerVar = false;
  void scrollListener() {
    if (_scrollController.position.pixels >= 280) {
      setState(() {
        checkerVar = true;
      });
    } else {
      checkerVar = false;
    }
    // print(
    //   "px ${_scrollController.position.pixels} ext ${_scrollController.position.maxScrollExtent}",
    // );
  }

  initSocket() {
    if (kIsWeb) {
      socket = IO.io(
        "https://chat-nest.onrender.com",
        IO.OptionBuilder().setExtraHeaders({'senderid': widget.uid}) // optional
            .build(),
      );
    } else {
      socket = IO.io(
        "https://chat-nest.onrender.com",
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
      if (mounted) {
        setState(() {
          descVal = data["description"] ?? "";
          descController.text = descVal;

          if (descVal != null) {
            descIsNull = false;
          }
        });
      }
    });

    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }

  List<dynamic> userList = [];

  void updatingDesc() {
    socket.emitWithAck(
        'updateGroupDesc', {"groupId": widget.id, "newGroupDesc": descVal},
        ack: (data) {
      setState(() {
        descVal = data["description"];
      });
    });
    socket.on('exception', (data) {
      print(data);
    });
  }

  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
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
            backgroundColor: (checkerVar == true)
                ? ThemeColors.mainThemeLight
                : Colors.transparent,
            elevation: 0,
            expandedHeight: size.height * 0.4 + 30,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              titlePadding: const EdgeInsets.fromLTRB(52, 0, 0, 16),
              centerTitle: false,
              stretchModes: const [StretchMode.zoomBackground],
              title: SizedBox(
                width: size.width,
                child: Text(
                  widget.name,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: ThemeColors.fontFamily,
                    color: ThemeColors.topTextColorLight,
                  ),
                ),
              ),
              background: Container(
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
                                        descVal = descVal.toString().trim();
                                        if (descVal.length != "") {
                                          setState(() {
                                            isSubmit = false;
                                            isEdit = !isEdit;
                                            descIsNull = !descIsNull;
                                            updatingDesc();
                                          });
                                        } else {
                                          setState(() {
                                            isSubmit = false;
                                            isEdit = !isEdit;
                                            descIsNull = !descIsNull;
                                            descVal = "";
                                          });
                                        }
                                      },
                                    )
                              : (!isEdit && !isSubmit)
                                  ? (descVal != "")
                                      ? IconButton(
                                          tooltip: "Edit Description",
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            descVal = descVal.toString().trim();
                                            if (descVal.length != 0) {
                                              setState(() {
                                                isEdit = !isEdit;
                                                isSubmit = true;
                                              });
                                            }
                                          },
                                        )
                                      : IconButton(
                                          tooltip: "Add Description",
                                          icon: const Icon(
                                              CupertinoIcons.plus_app),
                                          onPressed: () {
                                            descVal = descVal.toString().trim();
                                            if (descVal == "") {
                                              setState(() {
                                                isEdit = !isEdit;
                                                isSubmit = !isSubmit;
                                              });
                                            } else {
                                              AnimatedSnackBar.material(
                                                errorMsg,
                                                type:
                                                    AnimatedSnackBarType.error,
                                              ).show(context);
                                            }
                                          },
                                        )
                                  : IconButton(
                                      tooltip: "Submit",
                                      icon: const Icon(
                                          CupertinoIcons.checkmark_alt_circle),
                                      onPressed: () {
                                        descVal = descVal.toString().trim();
                                        if (descVal.length != "") {
                                          setState(() {
                                            isSubmit = false;
                                            isEdit = !isEdit;
                                          });
                                          updatingDesc();
                                        } else {
                                          setState(() {
                                            isSubmit = false;
                                            isEdit = !isEdit;
                                            descIsNull = true;
                                            descVal = "";
                                          });
                                        }
                                      },
                                    )
                        ],
                      ),
                      const Gap(20),
                      (isEdit)
                          ? TextField(
                              autofocus: true,
                              maxLength: 50,
                              controller: descController,
                              style: TextStyle(
                                color: ThemeColors.mainThemeLight,
                                fontFamily: ThemeColors.fontFamily,
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
                              : const Gap(2),
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
