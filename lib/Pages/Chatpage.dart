import 'package:flutter/material.dart';
import 'package:whatsapp/CustomUi/Customcard.dart';
import 'package:whatsapp/Screens/SelectContact.dart';
import 'package:whatsapp/model/ChatModel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
      name: "Eldho",
      icon: "person",
      isGroup: false,
      time: "3:00",
      currentMessage: "hi Eldho",
      status: "I find the bugs",
      id: 0,
      select: false,
    ),
    ChatModel(
      name: "Eldho1",
      icon: "person",
      isGroup: false,
      time: "3:50",
      currentMessage: "hi Eldho",
      status: "I find the bugs",
      id: 0,
      select: false,
    ),
    ChatModel(
      name: "Eldho2",
      icon: "person",
      isGroup: false,
      time: "4:00",
      currentMessage: "hi Eldho2",
      status: "I find the bugs",
      id: 0,
      select: false,
    ),
    ChatModel(
      name: "Eldho group",
      icon: "groups",
      isGroup: true,
      time: "4:00",
      currentMessage: "hi Eldho groups",
      status: "I find the bugs",
      id: 0,
      select: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => SelectContact(),
              ));
        },
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: chats[index],
        ),
      ),
    );
  }
}
