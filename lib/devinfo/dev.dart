import 'package:flutter/material.dart';

class Dev extends StatefulWidget {
  const Dev({
    super.key,
    required this.name,
    required this.icon,
    required this.role,
    required this.mail,
    required this.github,
    required this.linkedIn,
  });
  final String name;
  final String icon;
  final String role;
  final String mail;
  final String github;
  final String linkedIn;

  @override
  State<Dev> createState() => _DevState();
}

class _DevState extends State<Dev> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 16.0,
        ),
        child: Text('card'),
      ),
    );
  }
}
