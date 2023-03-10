import 'package:flutter/material.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:gap/gap.dart';

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

class _SignUpState extends State<SignUp> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool name = false;
  bool pass = false;
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
                  onTap: (pass && name) ? () {} : null,
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
