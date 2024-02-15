import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/CustomUi/OwnMessage.dart';
import 'package:whatsapp/CustomUi/ReplyCard.dart';
import 'package:whatsapp/model/ChatModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whatsapp/model/MessageModel.dart';

class IndividulaPage extends StatefulWidget {
  const IndividulaPage(
      {super.key, required this.chatModel, required this.sourchat});
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  State<IndividulaPage> createState() => _IndividulaPageState();
}

class _IndividulaPageState extends State<IndividulaPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  IO.Socket? socket;
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  List<MessageModel> messages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        show = false;
      }
    });
  }

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("https://chat-4k4n.onrender.com/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket?.connect();
    socket?.emit("signin", widget.sourchat.id);
    socket?.onConnect((data) {
      print("Connected");
      socket?.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket?.connected);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket?.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    print(messages);

    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/background.png",
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 70,
            titleSpacing: 0,
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                ),
                CircleAvatar(
                  child: widget.chatModel.isGroup
                      ? const Icon(
                          Icons.groups,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                  radius: 20,
                  backgroundColor: Colors.blueGrey,
                ),
              ],
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.name,
                      style: const TextStyle(
                        fontSize: 18.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "last seen today at 12:10",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
              PopupMenuButton(
                onSelected: (value) {
                  print(value);
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      child: Text("View Contact"),
                      value: "View Contact",
                    ),
                    const PopupMenuItem(
                      child: Text("Media, links, and docs"),
                      value: "Media, links, and docs",
                    ),
                    const PopupMenuItem(
                      child: Text("Whatsapp Web"),
                      value: "Whatsapp Web",
                    ),
                    const PopupMenuItem(
                      child: Text("Search"),
                      value: "Search",
                    ),
                    const PopupMenuItem(
                      child: Text("Mute Notification"),
                      value: "Mute Notification",
                    ),
                    const PopupMenuItem(
                      child: Text("Wallpaper"),
                      value: "Wallpaper",
                    ),
                  ];
                },
              ),
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: PopScope(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source") {
                          return OwnMessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else {
                          return ReplayCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                  margin: const EdgeInsets.only(
                                    left: 2,
                                    right: 2,
                                    bottom: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Type a message",
                                      prefixIcon: IconButton(
                                        icon: const Icon(Icons.emoji_emotions),
                                        onPressed: () {
                                          setState(() {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                            show = !show;
                                          });
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (builder) =>
                                                    bottomSheet(),
                                              );
                                            },
                                            icon: const Icon(Icons.attach_file),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.camera_alt),
                                          )
                                        ],
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(5),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                  right: 5,
                                  left: 2,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: const Color(0xFF075E54),
                                  radius: 25,
                                  child: IconButton(
                                      icon: Icon(
                                        sendButton ? Icons.send : Icons.mic,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        if (sendButton) {
                                          _scrollController.animateTo(
                                              _scrollController
                                                  .position.maxScrollExtent,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeOut);
                                          sendMessage(
                                              _controller.text,
                                              widget.sourchat.id,
                                              widget.chatModel.id);
                                          _controller.clear();
                                          setState(() {
                                            sendButton = false;
                                          });
                                        }
                                      }),
                                ),
                              ),
                            ],
                          ),
                          show
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height - 500,
                                  child: emojiSelect())
                              : Container()
                        ],
                      ),
                    ),
                  )
                ],
              ),
              canPop: false,
              onPopInvoked: (_) async {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(8),
        // ignore: unnecessary_const
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        print(emoji);
        setState(() {
          _controller.text = _controller.text + emoji.emoji;
        });
      },
      config: const Config(
          columns: 7,
          emojiSizeMax: 32.0,
          verticalSpacing: 0,
          horizontalSpacing: 0,
          initCategory: Category.RECENT,
          bgColor: Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          categoryIcons: CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL),
    );
  }
}
