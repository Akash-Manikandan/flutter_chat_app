import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void savePreference(String family) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fontFamily", family);
  }

  dynamic userData = "";
  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("userDetails");
    if (value != null) {
      setState(() {
        userData = jsonDecode(value);
      });
      // print(userData);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void changeFont(String fontFam1) {
    setState(() {
      fontFam = fontFam1;
      ThemeColors.fontFamily = fontFam1;
      savePreference(fontFam1);
    });
  }

  String fontFam = ThemeColors.fontFamily;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          overflow: TextOverflow.fade,
          softWrap: false,
          maxLines: 1,
          style: TextStyle(
            fontFamily: ThemeColors.fontFamily,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            (userData != "")
                ? Container(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: (size.width > 600)
                              ? 120
                              : (size.width > 250)
                                  ? 60
                                  : 30,
                          backgroundColor: ThemeColors.profileImageBg,
                          child: SvgPicture.string(
                            Jdenticon.toSvg(userData["userId"]),
                            width: (size.width > 600)
                                ? 200
                                : (size.width > 250)
                                    ? 100
                                    : 50,
                            height: (size.width > 600)
                                ? 200
                                : (size.width > 250)
                                    ? 100
                                    : 50,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Gap(20),
                        Expanded(
                          child: Container(
                            padding: (size.width > 600)
                                ? const EdgeInsets.fromLTRB(0, 30, 0, 10)
                                : (size.width > 250)
                                    ? const EdgeInsets.fromLTRB(0, 20, 0, 10)
                                    : const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        userData["username"],
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: (size.width > 600)
                                              ? 22
                                              : (size.width > 250)
                                                  ? 20
                                                  : 16,
                                          fontFamily: ThemeColors.fontFamily,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: Icon(
                                        Icons.edit_note_sharp,
                                        size: (size.width > 600)
                                            ? 35
                                            : (size.width > 250)
                                                ? 30
                                                : 25,
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(10),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: ReadMoreText(
                                    "Taylor Alison Swift (born December 13, 1989) is an American singer-songwriter. Her genre-spanning discography, artistic reinventions and songwriting have received critical praise and wide media coverage. Born in West Reading, Pennsylvania, Swift moved to Nashville at age 14 to become a country artist. She signed a songwriting deal with Sony/ATV Music Publishing in 2004 and a recording contract with Big Machine Records in 2005. Her 2006 self-titled debut album made her the first female country singer to write a U.S. platinum-certified album. Swift's next albums, Fearless (2008) and Speak Now (2010), explored country pop. The former's \"Love Story\" and \"You Belong with Me\" were the first country songs to top the U.S. pop and all-genre airplay charts, respectively. She experimented with rock and electronic styles on Red (2012), which featured her first Billboard Hot 100 number-one song, \"We Are Never Ever Getting Back Together\", and eschewed her country image in her synth-pop album, 1989 (2014), supported by chart-topping songs \"Shake It Off\", \"Blank Space\", and \"Bad Blood\". Media scrutiny inspired the urban-flavored Reputation (2017) and its number-one single \"Look What You Made Me Do\".",
                                    trimLines: 3,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: "Read more",
                                    trimExpandedText: "...Show less",
                                    textAlign: TextAlign.justify,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      const Gap(10),
                      Text(
                        "What font do you want?",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: ThemeColors.fontFamily,
                        ),
                      ),
                    ],
                  ),
                  const Gap(5),
                  const Divider(),
                  RadioListTile(
                    title: Text(
                      "Nexa",
                      style: TextStyle(
                        fontFamily: ThemeColors.fontFamily,
                      ),
                    ),
                    value: "Nexa",
                    groupValue: fontFam,
                    onChanged: (value) {
                      changeFont(value.toString());
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      "Montserrat",
                      style: TextStyle(
                        fontFamily: ThemeColors.fontFamily,
                      ),
                    ),
                    value: "Montserrat",
                    groupValue: fontFam,
                    onChanged: (value) {
                      changeFont(value.toString());
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      "Poppins",
                      style: TextStyle(
                        fontFamily: ThemeColors.fontFamily,
                      ),
                    ),
                    value: "Poppins",
                    groupValue: fontFam,
                    onChanged: (value) {
                      changeFont(value.toString());
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      "Soban",
                      style: TextStyle(
                        fontFamily: ThemeColors.fontFamily,
                      ),
                    ),
                    value: "Soban",
                    groupValue: fontFam,
                    onChanged: (value) {
                      changeFont(value.toString());
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      "Fredoka",
                      style: TextStyle(
                        fontFamily: ThemeColors.fontFamily,
                      ),
                    ),
                    value: "Fredoka",
                    groupValue: fontFam,
                    onChanged: (value) {
                      changeFont(value.toString());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
