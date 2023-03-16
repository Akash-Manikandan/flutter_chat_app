import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/addgroup/addgroup.dart';
import 'package:flutter_chat_app/authentication.dart';
import 'package:flutter_chat_app/components/flutter_circular_fab.dart';
import 'package:flutter_chat_app/devinfo/devinfo.dart';
import 'package:flutter_chat_app/homepage/homepage.dart';
import 'package:flutter_chat_app/settings/settings1.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage msg) async {
  print("handling a background msg: ${msg.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
      // home: const MyHomePage(),
      home: AnimatedSplashScreen(
        duration: 1000,
        splashIconSize: 300,
        splashTransition: SplashTransition.scaleTransition,
        // pageTransitionType: PageTransitionType.topToBottomPop,
        centered: true,
        splash: const Image(
          image: AssetImage('assets/images/logo.png'),
        ),
        nextScreen: const MyHomePage(),
      ),
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
  String? mtoken = " ";
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
    String? fontFamily = prefs.getString("fontFamily");
    if (fontFamily == null) {
      setState(() {
        ThemeColors.fontFamily = "Fredoka";
      });
    } else {
      setState(() {
        ThemeColors.fontFamily = fontFamily;
      });
    }
  }

  void fontLoder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fontFamily = prefs.getString("fontFamily");
    if (fontFamily == null) {
      setState(() {
        ThemeColors.fontFamily = "Fredoka";
      });
    } else {
      setState(() {
        ThemeColors.fontFamily = fontFamily;
      });
    }
  }

  @override
  initState() {
    super.initState();
    requestPermission();
    getToken();
    getAsync();
    initinfo();
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  initinfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationsSettings =
        InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse: (detail) async {
      try {
        if (detail != null) {
        } else {}
      } catch (e) {}
      return;
    });
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage msg) async {
        print("onmessagee***************************");
        print(
            "onMessage: ${msg.notification?.title}/${msg.notification?.body}");
        BigTextStyleInformation bigTextStyleInformation =
            BigTextStyleInformation(
          msg.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: msg.notification!.title.toString(),
          htmlFormatContentTitle: true,
        );
        AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'dbfood',
          'dbfood',
          importance: Importance.high,
          styleInformation: bigTextStyleInformation,
          priority: Priority.high,
          playSound: true,
        );
        NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(0, msg.notification?.title,
            msg.notification?.body, platformChannelSpecifics,
            payload: msg.data['body']);
      },
    );
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) async {
      setState(() {
        mtoken = token;
        print("My token is $mtoken");
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? stringVal = prefs.getString('userId');
      if (stringVal != null) {
        saveToken(token!, stringVal);
      }
    });
  }

  void saveToken(String token, String stringVal) async {
    final tok = <String, String>{
      "token": token,
    };
    await FirebaseFirestore.instance
        .collection("UserTokens")
        .doc(stringVal)
        .set(tok);
  }

  void requestPermission() async {
    FirebaseMessaging msg = FirebaseMessaging.instance;
    NotificationSettings settings = await msg.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted Permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User declined");
    }
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
          ? Authentication(
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
                      onPressed: () {
                        fabKey.currentState?.close();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DevInfo(),
                          ),
                        );
                      },
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(24.0),
                      child: const Tooltip(
                        message: "Developers' Information",
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
                            builder: (context) => const Settings1(),
                          ),
                        ).then((_) {
                          fontLoder();
                        });
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
