import 'package:flutter/material.dart';
import 'package:whatsapp/CustomUi/Customcard.dart';
import 'package:whatsapp/Screens/SelectContact.dart';
import 'package:whatsapp/model/ChatModel.dart';

class ChatPage extends StatefulWidget {
  final List<ChatModel> chatmodels;
  final ChatModel sourchat;
  const ChatPage({super.key, required this.chatmodels, required this.sourchat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (contex, index) => CustomCard(
          chatModel: widget.chatmodels[index],
          sourchat: widget.sourchat,
        ),
      ),
    );
  }
}
