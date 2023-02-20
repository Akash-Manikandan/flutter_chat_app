import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/addgroup/addgroup.dart';
import 'package:flutter_chat_app/components/flutter_circular_fab.dart';
import 'package:flutter_chat_app/homepage/homepage.dart';
import 'package:flutter_chat_app/login.dart';
import 'package:flutter_chat_app/settings/settings.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: ThemeColors.mainThemeLight,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ThemeColors.mainThemeLight,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

Route _createRoute(String? str) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const AddGroup(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isClicked = false;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  bool isAuth = false;
  void onAuthStateChange(bool val) {
    setState(() {
      isAuth = val;
    });
  }

  String? stringValue;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    stringValue = prefs.getString('userId');
    if (stringValue != null) {
      onAuthStateChange(true);
    } else {
      onAuthStateChange(false);
    }
  }

  @override
  initState() {
    super.initState();
    getAsync();
  }

  getAsync() async {
    await getStringValuesSF();
  }

  void closeNavigation() {
    fabKey.currentState?.close();
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("userDetails");
    prefs.remove('userId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: (isAuth != true)
          ? Login(
              onAuthStateChange: onAuthStateChange,
            )
          : GestureDetector(
              onTap: isClicked
                  ? () {
                      fabKey.currentState?.close();
                    }
                  : () {},
              child: Opacity(
                opacity: !isClicked ? 1 : 0.5,
                child: HomePage(
                  isClicked: isClicked,
                  onAuthStateChange: onAuthStateChange,
                  closeNavigation: closeNavigation,
                ),
              ),
            ),
      backgroundColor: Colors.white,
      floatingActionButton: (isAuth != true)
          ? const SizedBox.shrink()
          : Builder(
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
                    child: Tooltip(
                      message: "Options",
                      child: Icon(
                        Icons.add,
                        color: ThemeColors.topTextColorLight,
                        size: 40,
                      ),
                    ),
                  ),
                  fabCloseIcon: const Center(
                    child: Tooltip(
                      message: "Close",
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 40,
                      ),
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
                      onPressed: () async {
                        // await removeValues();
                        // onAuthStateChange(false);
                        // isClicked = false;
                      },
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(24.0),
                      child: const Tooltip(
                        message: "Developer Information",
                        child: Icon(
                          CupertinoIcons.text_bubble,
                          color: ThemeColors.topTextColorLight,
                          size: 40,
                        ),
                      ),
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        fabKey.currentState?.close();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Settings(),
                          ),
                        );
                      },
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(24.0),
                      child: const Tooltip(
                        message: "Settings",
                        child: Icon(
                          CupertinoIcons.settings_solid,
                          color: ThemeColors.topTextColorLight,
                          size: 40,
                        ),
                      ),
                    ),
                    RawMaterialButton(
                      onPressed: () {},
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(24.0),
                      child: const Tooltip(
                        message: "Phone",
                        child: Icon(
                          CupertinoIcons.phone_fill,
                          color: ThemeColors.topTextColorLight,
                          size: 40,
                        ),
                      ),
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        fabKey.currentState?.close();
                        Navigator.of(context).push(
                          _createRoute(stringValue),
                        );
                      },
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(24.0),
                      child: const Tooltip(
                        message: "Add Group",
                        child: Icon(
                          CupertinoIcons.person_add_solid,
                          color: ThemeColors.topTextColorLight,
                          size: 40,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
    );
  }
}
