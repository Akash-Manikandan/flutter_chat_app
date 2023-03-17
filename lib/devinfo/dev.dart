import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dev extends StatefulWidget {
  const Dev({
    super.key,
    required this.name,
    required this.icon,
    required this.role,
    required this.mail,
    required this.github,
    required this.linkedIn,
    required this.left,
  });
  final String name;
  final String icon;
  final String role;
  final String mail;
  final String github;
  final String linkedIn;
  final int left;

  @override
  State<Dev> createState() => _DevState();
}

class _DevState extends State<Dev> {
  // void initState() {
  //   print(widget.left);
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 200,
      width: size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: (size.width < 450) ? 6.0 : 12.0,
          vertical: (size.width < 450) ? 5.0 : 16.0,
        ),
        child: Column(
          children: [
            const Gap(10),
            Row(
              // textDirection:
              //     (widget.left == 0) ? TextDirection.ltr : TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ThemeColors.profileImageBg,
                  ),
                  child: CircleAvatar(
                    radius: (size.width < 450) ? 40 : 60,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(widget.icon),
                  ),
                ),
                (size.width < 450) ? const Gap(5) : const Gap(20),

                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(
                          color: ThemeColors.mainThemeLight,
                          fontSize: (size.width < 450) ? 18 : 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: ThemeColors.fontFamily,
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 1,
                      ),
                      const Gap(5),
                      Text(
                        widget.role,
                        style: TextStyle(
                          color: ThemeColors.mainThemeLight,
                          fontSize: (size.width < 450) ? 16 : 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: ThemeColors.fontFamily,
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 1,
                      ),
                      const Gap(5),
                    ],
                  ),
                ),
                (size.width < 450) ? const Gap(0) : const Gap(20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      tooltip: "Mail",
                      icon: Icon(
                        Icons.mail_outline,
                        size: (size.width < 450) ? 20 : 30,
                      ),
                      onPressed: () {
                        setState(() async {});
                      },
                    ),
                    (size.width < 450) ? const Gap(0) : const Gap(5),
                    IconButton(
                      tooltip: "GitHub",
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                        size: (size.width < 450) ? 20 : 30,
                      ),
                      onPressed: () {
                        setState(() async {});
                      },
                    ),
                    (size.width < 450) ? const Gap(0) : const Gap(5),
                    IconButton(
                      tooltip: "LinkedIn",
                      icon: FaIcon(
                        FontAwesomeIcons.linkedin,
                        size: (size.width < 450) ? 20 : 30,
                      ),
                      onPressed: () {
                        setState(() async {
                          //                           if (await canLaunchUrl(url))
                          //   await launchUrl(url);
                          // else
                          //   // can't launch url, there is some error
                          //   throw "Could not launch $url";
                        });
                      },
                    ),
                  ],
                ),
                // (widget.left == 0) ? const Gap(0) : const Gap(0),
              ],
            ),
            const Gap(10),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
