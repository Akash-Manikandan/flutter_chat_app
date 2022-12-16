import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Opacity(
        opacity: !isClicked ? 1 : 0.2,
        child: const HomePage(),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
          Icon(Icons.call_split, size: 30),
          Icon(Icons.perm_identity, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: ThemeColors.mainThemeLight,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {},
        letIndexChange: (index) => true,
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FabCircularMenu(
            alignment: Alignment.bottomRight,
            ringColor: ThemeColors.mainThemeLight,
            ringDiameter: 500.0,
            ringWidth: 150.0,
            fabSize: 64.0,
            fabElevation: 8.0,
            fabIconBorder: const CircleBorder(),
            fabColor: Colors.white,
            fabOpenIcon: const Icon(
              Icons.add,
              color: ThemeColors.mainThemeLight,
              size: 40,
            ),
            fabCloseIcon: const Icon(
              Icons.close,
              color: Colors.red,
              size: 40,
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
                  color: Colors.white,
                  size: 40,
                ),
              ),
              RawMaterialButton(
                onPressed: () {},
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              RawMaterialButton(
                onPressed: () {},
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: const Icon(
                  CupertinoIcons.phone_fill,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              RawMaterialButton(
                onPressed: () {},
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: const Icon(
                  CupertinoIcons.person_add_solid,
                  color: Colors.white,
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
