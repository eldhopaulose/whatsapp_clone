import 'package:flutter/material.dart';
import 'package:whatsapp/CustomUi/ButtonCard.dart';
import 'package:whatsapp/Screens/Homescreen.dart';
import 'package:whatsapp/model/ChatModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel? sourceChat;
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Eldho",
      icon: "person",
      isGroup: false,
      time: "3:00",
      currentMessage: "hi Eldho",
      status: "I find the bugs",
      id: 1,
      select: false,
    ),
    ChatModel(
      name: "Eldho1",
      icon: "person",
      isGroup: false,
      time: "3:50",
      currentMessage: "hi Eldho",
      status: "I find the bugs",
      id: 2,
      select: false,
    ),
    ChatModel(
      name: "Eldho2",
      icon: "person",
      isGroup: false,
      time: "4:00",
      currentMessage: "hi Eldho2",
      status: "I find the bugs",
      id: 3,
      select: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chatmodels.length,
          itemBuilder: (contex, index) => InkWell(
                onTap: () {
                  sourceChat = chatmodels.removeAt(index);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Homescreen(
                                chatmodels: chatmodels,
                                // sourchat: sourceChat,
                              )));
                },
                child: ButtonCard(
                  name: chatmodels[index].name,
                  icon: Icons.person,
                ),
              )),
    );
  }
}
