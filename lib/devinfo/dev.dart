import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

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
      height: 180,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 16.0,
        ),
        child: Column(
          children: [
            Row(
              textDirection:
                  (widget.left == 0) ? TextDirection.ltr : TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ThemeColors.profileImageBg,
                    // color: ThemeColors.topTextColorLight,
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(widget.icon
                        // 'https://api.dicebear.com/5.x/avataaars/png?seed=Ka&eyebrows=defaultNatural&eyes=default,happy&mouth=default,smile',
                        ),
                  ),
                ),
                const Gap(20),
                Flexible(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.name,
                          style: TextStyle(
                            color: ThemeColors.mainThemeLight,
                            fontSize: 22,
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
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: ThemeColors.fontFamily,
                          ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                        const Gap(5),
                        // Text(
                        //   widget.mail,
                        //   style: TextStyle(
                        //     color: ThemeColors.mainThemeLight,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w600,
                        //     fontFamily: ThemeColors.fontFamily,
                        //   ),
                        //   overflow: TextOverflow.fade,
                        //   softWrap: false,
                        //   maxLines: 1,
                        // ),
                      ]),
                ),
                const Gap(20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      tooltip: "Mail",
                      icon: const Icon(
                        Icons.mail_outline,
                        size: 40,
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
                    const Image(
                      image: AssetImage('../../assets/images/github.png'),
                      width: 40,
                      height: 40,
                    ),
                    const Gap(5),
                    const Image(
                      image: AssetImage('../../assets/images/linkedin.png'),
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
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
