import 'package:flutter/material.dart';
import 'package:flutter_chat_app/login.dart';
import 'package:flutter_chat_app/signup.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key, required this.onAuthStateChange});
  final Function onAuthStateChange;
  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool login = true;
  void changeScreen() {
    setState(() {
      login = !login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (login == false)
        ? SignUp(
            onAuthStateChange: widget.onAuthStateChange,
            changeScreen: changeScreen,
          )
        : Login(
            onAuthStateChange: widget.onAuthStateChange,
            changeScreen: changeScreen,
          );
  }
}
