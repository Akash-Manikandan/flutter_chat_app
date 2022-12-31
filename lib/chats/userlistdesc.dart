import 'package:flutter/material.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';

class UserListDesc extends StatefulWidget {
  const UserListDesc({
    super.key,
    required this.name,
    required this.id,
    required this.lastMsg,
    required this.time,
  });
  final String name;
  final String id;
  final String lastMsg;
  final String time;

  @override
  State<UserListDesc> createState() => _UserListDescState();
}

class _UserListDescState extends State<UserListDesc> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        color:
            isPressed ? ThemeColors.lighterShadeTextLight : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 16.0,
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ThemeColors.profileImageBg,
                ),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: SvgPicture.string(
                    Jdenticon.toSvg(widget.id),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const Gap(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.name,
                          style: TextStyle(
                            color: ThemeColors.mainThemeLight,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: ThemeColors.fontFamily,
                          ),
                        ),
                        Text(
                          widget.time,
                          style: TextStyle(
                            color: ThemeColors.mainThemeLight,
                            fontSize: 14,
                            fontFamily: ThemeColors.fontFamily,
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.lastMsg,
                          style: TextStyle(
                            fontFamily: ThemeColors.fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
