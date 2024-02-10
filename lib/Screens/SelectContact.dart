import 'package:flutter/material.dart';
import 'package:whatsapp/CustomUi/ButtonCard.dart';
import 'package:whatsapp/CustomUi/ContactCard.dart';
import 'package:whatsapp/Screens/CreateGroup.dart';
import 'package:whatsapp/model/ChatModel.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<ChatModel> contacts = [
    ChatModel(
      name: "Dev Stack",
      status: "A full stack developer",
      icon: "",
      currentMessage: "",
      isGroup: false,
      id: 0,
      time: "",
      select: false,
    ),
    ChatModel(
      name: "Balram",
      status: "Flutter Developer...........",
      icon: "",
      currentMessage: "",
      isGroup: false,
      id: 0,
      time: "",
      select: false,
    ),
    ChatModel(
      name: "Saket",
      status: "Web developer...",
      icon: "",
      currentMessage: "",
      isGroup: false,
      id: 0,
      time: "",
      select: false,
    ),
    ChatModel(
      name: "Bhanu Dev",
      status: "App developer....",
      icon: "",
      currentMessage: "",
      isGroup: false,
      id: 0,
      time: "",
      select: false,
    ),
    ChatModel(
      name: "Collins",
      status: "Raect developer..",
      icon: "",
      currentMessage: "",
      isGroup: false,
      id: 0,
      time: "",
      select: false,
    ),
    ChatModel(
      name: "Kishor",
      status: "Full Stack Web",
      icon: "",
      currentMessage: "",
      isGroup: false,
      id: 0,
      time: "",
      select: false,
    ),
    ChatModel(
      name: "Testing1",
      status: "Example work",
      icon: "",
      currentMessage: "",
      isGroup: false,
      id: 0,
      time: "",
      select: false,
    ),
    ChatModel(
      name: "Testing2",
      status: "Sharing is caring",
      icon: "",
      currentMessage: "",
      isGroup: false,
      id: 0,
      time: "",
      select: false,
    ),
    ChatModel(
      name: "Divyanshu",
      status: ".....",
      icon: "",
      currentMessage: "",
      isGroup: false,
      id: 0,
      time: "",
      select: false,
    ),
    ChatModel(
      name: "Helper",
      status: "Love you Mom Dad",
      icon: "",
      currentMessage: "",
      isGroup: false,
      id: 0,
      time: "",
      select: false,
    ),
    ChatModel(
      name: "Tester",
      status: "I find the bugs",
      icon: "",
      currentMessage: "",
      isGroup: false,
      id: 0,
      time: "",
      select: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Contact",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("256 Contact",
                  style: TextStyle(
                    fontSize: 13,
                  )),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 25,
              ),
            ),
            PopupMenuButton(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    child: Text("Invite a friend"),
                    value: "Invite a friend",
                  ),
                  const PopupMenuItem(
                    child: Text("Contacts"),
                    value: "Contacts",
                  ),
                  const PopupMenuItem(
                    child: Text("Refresh"),
                    value: "Refresh",
                  ),
                  const PopupMenuItem(
                    child: Text("Help"),
                    value: "Help",
                  ),
                ];
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: contacts.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const CreateGroup()));
                },
                child: const ButtonCard(
                  icon: Icons.group,
                  name: "New group",
                ),
              );
            } else if (index == 1) {
              return const ButtonCard(
                icon: Icons.person_add,
                name: "New contact",
              );
            }
            return ContactCard(
              contact: contacts[index - 2],
            );
          },
        ));
  }
}
