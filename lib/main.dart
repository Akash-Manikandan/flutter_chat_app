import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/homepage/homepage.dart';
import 'package:flutter_chat_app/themecolors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: ThemeColors.mainThemeLight,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ThemeColors.mainThemeLight,
        ),
        fontFamily: ThemeColors.fontFamily,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isClicked = false;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          isClicked ? fabKey.currentState?.close() : null;
        },
        child: Opacity(
          opacity: !isClicked ? 1 : 0.3,
          child: HomePage(
            isClicked: isClicked,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: Builder(
        builder: (context) {
          return FabCircularMenu(
            key: fabKey,
            alignment: Alignment.bottomRight,
            ringColor: ThemeColors.mainThemeLight,
            ringDiameter: 500.0,
            ringWidth: 150.0,
            fabSize: 64.0,
            fabElevation: 8.0,
            fabIconBorder: const CircleBorder(),
            fabColor: ThemeColors.mainThemeLight,
            fabOpenIcon: const Center(
              child: Icon(
                Icons.add,
                color: ThemeColors.topTextColorLight,
                size: 40,
              ),
            ),
            fabCloseIcon: const Center(
              child: Icon(
                Icons.close,
                color: Colors.red,
                size: 40,
              ),
            ),
            fabMargin: const EdgeInsets.all(16.0),
            animationDuration: const Duration(milliseconds: 200),
            animationCurve: Curves.easeInOutCirc,
            onDisplayChange: ((isOpen) {
              setState(() {
                isClicked = !isClicked;
              });
            }),
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {},
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: const Icon(
                  Icons.people_alt_rounded,
                  color: ThemeColors.topTextColorLight,
                  size: 40,
                ),
              ),
              RawMaterialButton(
                onPressed: () {},
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: ThemeColors.topTextColorLight,
                  size: 40,
                ),
              ),
              RawMaterialButton(
                onPressed: () {},
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: const Icon(
                  CupertinoIcons.phone_fill,
                  color: ThemeColors.topTextColorLight,
                  size: 40,
                ),
              ),
              RawMaterialButton(
                onPressed: () {},
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: const Icon(
                  CupertinoIcons.person_add_solid,
                  color: ThemeColors.topTextColorLight,
                  size: 40,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
