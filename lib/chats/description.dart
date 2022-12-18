import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:readmore/readmore.dart';

class Description extends StatelessWidget {
  const Description({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // extendBodyBehindAppBar: true,
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
            expandedHeight: size.height * 0.4,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              title: Text(
                id,
                style: const TextStyle(
                  color: ThemeColors.mainThemeLight,
                ),
              ),
              background: Container(
                width: size.width,
                height: size.height * 0.4,
                color: ThemeColors.profileImageBgLightestVersion,
                child: Hero(
                  tag: "Profile",
                  child: SvgPicture.string(
                    Jdenticon.toSvg(id),
                    width: size.width,
                    height: size.height * 0.4,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      ReadMoreText(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
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


// [
//           Stack(
//             children: [
//               Container(
//                 width: size.width,
//                 height: size.height * 0.4,
//                 color: ThemeColors.profileImageBgLightestVersion,
//                 child: Hero(
//                   tag: "Profile",
//                   child: SvgPicture.string(
//                     Jdenticon.toSvg(id),
//                     width: size.width,
//                     height: size.height * 0.4,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 18.0,
//                   ),
//                   child: Text(
//                     id,
//                     style: const TextStyle(
//                       fontSize: 30,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           
//         ],