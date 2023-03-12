import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
    required this.onAuthStateChange,
    required this.changeScreen,
  });
  final Function onAuthStateChange;
  final Function changeScreen;
  @override
  State<SignUp> createState() => _SignUpState();
}

addStringToSF(String info) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var res = jsonDecode(info);
  prefs.setString("userId", res["userId"]);
  prefs.setString('userDetails', info);
}

Future<dynamic> loginReq(String username, String password) async {
  final response = await http.post(
    Uri.parse('https://chat-nest.onrender.com/user/signupUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  var result = jsonDecode(response.body);
  return result;
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool name = false;
  bool pass = false;
  dynamic caller() async {
    return await loginReq(
      _name.text.trim(),
      _password.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Center(
                    child: Text(
                      "Sign Up to Chatbox",
                    ),
                  ),
                  const Gap(20),
                  const Center(
                    child: Text(
                      "Welcome back! Sign up using your social account or email to continue us",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Gap(40),
                  Row(
                    children: const <Widget>[
                      Text(
                        "Your Name",
                      ),
                    ],
                  ),
                  TextField(
                    controller: _name,
                    onChanged: (value) {
                      setState(() {
                        if (_name.text.trim().isEmpty ||
                            _password.text.trim().isEmpty) {
                          name = false;
                          pass = false;
                        } else {
                          name = true;
                          pass = true;
                        }
                      });
                    },
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ThemeColors.mainThemeLight,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ThemeColors.mainThemeLight,
                        ),
                      ),
                    ),
                    cursorColor: ThemeColors.topTextColorLight,
                    cursorHeight: 26,
                    style: TextStyle(
                      color: ThemeColors.topTextColorLight,
                      fontSize: 16,
                      fontFamily: ThemeColors.fontFamily,
                    ),
                  ),
                  const Gap(40),
                  Row(
                    children: const <Widget>[
                      Text(
                        "Your Password",
                      ),
                    ],
                  ),
                  TextField(
                    controller: _password,
                    onChanged: (value) {
                      setState(() {
                        if (_password.text.trim().isEmpty ||
                            _name.text.trim().isEmpty) {
                          pass = false;
                          name = false;
                        } else {
                          pass = true;
                          name = true;
                        }
                      });
                    },
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ThemeColors.mainThemeLight,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ThemeColors.mainThemeLight,
                        ),
                      ),
                    ),
                    cursorColor: ThemeColors.topTextColorLight,
                    cursorHeight: 26,
                    style: TextStyle(
                      color: ThemeColors.topTextColorLight,
                      fontSize: 16,
                      fontFamily: ThemeColors.fontFamily,
                    ),
                  )
                ],
              ),
              const Gap(150),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (pass && name)
                      ? () async {
                          dynamic smt = await caller();
                          if (smt["verified"] == true) {
                            widget.onAuthStateChange(true);
                            addStringToSF(
                              jsonEncode(smt),
                            );
                            widget.onAuthStateChange(smt["verified"]);
                          } else {
                            // ignore: use_build_context_synchronously
                            showDialog<String>(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Error'),
                                content: Text(smt["message"][0]),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      : null,
                  child: Container(
                    width: size.width * 0.85,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (!pass && !name)
                          ? Colors.grey
                          : ThemeColors.topTextColorLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text("Ok"),
                    ),
                  ),
                ),
              ),
              const Gap(30),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    widget.changeScreen();
                  },
                  child: Container(
                    width: size.width * 0.85,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (!pass && !name)
                          ? Colors.grey
                          : ThemeColors.topTextColorLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text("Login"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
