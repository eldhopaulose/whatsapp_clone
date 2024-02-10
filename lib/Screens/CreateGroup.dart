import 'package:flutter/material.dart';
import 'package:whatsapp/CustomUi/AvatarCard%20.dart';
import 'package:whatsapp/CustomUi/ButtonCard.dart';
import 'package:whatsapp/CustomUi/ContactCard.dart';
import 'package:whatsapp/model/ChatModel.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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
  List<ChatModel> groupmember = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Group",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Add participants",
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
          ],
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: contacts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    height: groupmember.length > 0 ? 90 : 10,
                  );
                }
                return InkWell(
                  onTap: () {
                    if (contacts[index - 1].select == false) {
                      setState(() {
                        contacts[index - 1].select = true;
                        groupmember.add(contacts[index]);
                      });
                    } else {
                      setState(() {
                        contacts[index - 1].select = false;
                        groupmember.remove(contacts[index]);
                      });
                    }
                  },
                  child: ContactCard(
                    contact: contacts[index - 1],
                  ),
                );
              },
            ),
            groupmember.length > 0
                ? Column(
                    children: [
                      Container(
                        height: 75,
                        color: Colors.white,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            if (contacts[index].select == true) {
                              return InkWell(
                                  onTap: () {
                                    setState(() {
                                      contacts[index].select = false;
                                      groupmember.remove(contacts[index]);
                                    });
                                  },
                                  child:
                                      AvatarCard(chatModel: contacts[index]));
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      )
                    ],
                  )
                : Container(),
          ],
        ));
  }
}
