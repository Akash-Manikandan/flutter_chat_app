import 'package:flutter/material.dart';
import 'package:flutter_chat_app/homepage/userlistwithouthero.dart';
import 'package:flutter_chat_app/themecolors.dart';
import 'package:gap/gap.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({super.key});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  Set<String> list = {};
  List<Map<String, dynamic>> userList = [
    {
      "id": "Karthi1",
      "name": "Karthi",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Aishwarya2",
      "name": "Aishwarya",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "Akash3",
      "name": "Akash",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Karthi4",
      "name": "Karthi",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Aishwarya5",
      "name": "Aishwarya",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "Akash6",
      "name": "Akash",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Karthi7",
      "name": "Karthi",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Aishwarya8",
      "name": "Aishwarya",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "Akash9",
      "name": "Akash",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Karthi10",
      "name": "Karthi",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Aishwarya11",
      "name": "Aishwarya",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "Akash12",
      "name": "Akash",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Karthi13",
      "name": "Karthi",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    },
    {
      "id": "Aishwarya15",
      "name": "Aishwarya",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 7,
    },
    {
      "id": "Akash16",
      "name": "Akash",
      "lastMsg": "Hello, Good Morning",
      "time": "11:47 PM",
      "count": 4,
    }
  ];
  void addValue(String id) {
    setState(() {
      list.add(id);
    });
  }

  void removeValue(String id) {
    setState(() {
      list.remove(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: const Icon(Icons.arrow_back_ios),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            const Gap(10),
            const Text("Add Group"),
          ],
        ),
        iconTheme: const IconThemeData(
          color: ThemeColors.topTextColorLight,
        ),
        titleTextStyle: const TextStyle(
          color: ThemeColors.topTextColorLight,
          fontSize: 20,
        ),
        actions: [
          (list.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.only(
                    right: 12.0,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    tooltip: "Add new group",
                    icon: const Icon(
                      Icons.add,
                      size: 32,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...userList.map(
              (each) {
                return UserListWithoutHero(
                  name: each["name"],
                  id: each["id"],
                  lastMsg: each["lastMsg"],
                  time: each["time"],
                  count: each["count"],
                  listAdd: addValue,
                  listRemove: removeValue,
                  lcount: list.length,
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
