import 'package:flutter/material.dart';

class DevInfo extends StatefulWidget {
  const DevInfo({super.key});

  @override
  State<DevInfo> createState() => _DevInfoState();
}

class _DevInfoState extends State<DevInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Do Something"),
      ),
    );
  }
}
