import 'package:flutter/material.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';

class UserList extends StatelessWidget {
  const UserList({
    super.key,
    required this.name,
    required this.id,
    required this.lastMsg,
    required this.time,
    required this.count,
  });
  final String name;
  final String id;
  final String lastMsg;
  final String time;
  final int count;
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Row(
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
                    Jdenticon.toSvg(id),
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
                          name,
                          style: const TextStyle(
                            color: ThemeColors.mainThemeLight,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Gap(5),
                        Text(
                          time,
                          style: const TextStyle(
                            color: ThemeColors.mainThemeLight,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          lastMsg,
                        ),
                        const Gap(5),
                        Container(
                          height: 20,
                          width: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ThemeColors.mainThemeLight,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "$count",
                              style: const TextStyle(
                                color: ThemeColors.topTextColorLight,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
