import 'package:app/whatsAppClone2/ChatModel.dart';
import 'package:app/whatsAppClone2/MessageModel.dart';
import 'package:app/whatsAppClone2/MessageView.dart';
import 'package:app/whatsAppClone2/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  UserModel user;
  UserModel? other;
  ChatModel chat;

  ChatPage(this.chat, this.user, this.other);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController controller;
  late FocusNode focusNode;
  var emojiShowing = false;
  var db = FirebaseFirestore.instance;
  var ref = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    focusNode = new FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.other?.nickname ?? "Loading..."),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: db
                  .collection("messages") //.orderBy("time")
                  .where("chatId", isEqualTo: widget.chat.id)
                  .orderBy("time", descending: true)
                  .limit(100)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                if (!snapshot.hasData)
                  return Center(
                    child: Text("Loading..."),
                  );

                var messages = MessageModel.fromDocs(snapshot.data!.docs);

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return MessageView(
                        message: messages[index], user: widget.user);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 19, 19, 19),
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      actionIcon(
                          icon: Icon(Icons.emoji_emotions),
                          onPressed: () {
                            setState(() {
                              emojiShowing = !emojiShowing;
                            });
                          }),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      Expanded(
                        child: TextField(
                          maxLines: 4,
                          minLines: 1,
                          focusNode: focusNode,
                          controller: controller,
                          textInputAction: TextInputAction.newline,
                          onSubmitted: (value) {
                            // send(value);
                            // focusNode.requestFocus();
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Message",
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      actionIcon(icon: Icon(Icons.attachment)),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      actionIcon(icon: Icon(Icons.photo)),
                      // SizedBox(
                      //   width: 10,
                      // ),
                    ],
                  ),
                )),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).primaryColor),
                    child: IconButton(
                      iconSize: 20,
                      splashRadius: 1,
                      icon: Icon(
                        Icons.send,
                      ),
                      onPressed: () {
                        send(controller.text);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Offstage(
            offstage: !emojiShowing,
            child: SizedBox(
                height: 250,
                child: EmojiPicker(
                  textEditingController: controller,
                  onBackspacePressed: () {},
                  config: Config(
                    columns: 7,
                    // Issue: https://github.com/flutter/flutter/issues/28894
                    emojiSizeMax: 32,
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    gridPadding: EdgeInsets.zero,
                    initCategory: Category.RECENT,
                    bgColor: Theme.of(context).primaryColor,
                    indicatorColor: Colors.green,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.green,
                    backspaceColor: Theme.of(context).secondaryHeaderColor,
                    skinToneDialogBgColor:
                        Theme.of(context).secondaryHeaderColor,
                    skinToneIndicatorColor: Colors.grey,
                    enableSkinTones: true,
                    showRecentsTab: true,
                    recentsLimit: 28,
                    replaceEmojiOnLimitExceed: false,
                    noRecents: const Text(
                      'No Recents',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    loadingIndicator: const SizedBox.shrink(),
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL,
                    checkPlatformCompatibility: true,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void send(String message) {
    message = message.trim();
    if (message.isNotEmpty) {
      var t = Timestamp.fromDate(DateTime.now());
      db.collection("messages").add(<String, dynamic>{
        "chatId": widget.chat.id,
        "text": message,
        "time": t,
        "userId": widget.user.id
      });
      controller.text = "";
      if (widget.other?.id != null) {
        ref.child("notifications").push().set(<String, dynamic>{
          "userId": widget.user.id,
          "chatId": widget.chat.id,
          "otherId": widget.other?.id
        });
      }
    }
  }

  Widget actionIcon({required Icon icon, void Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.5),
      // padding: EdgeInsets.zero,
      child: IconButton(
        iconSize: 25,
        splashRadius: 1,
        icon: icon,
        padding: EdgeInsets.zero,
        onPressed: onPressed,
      ),
    );
  }
}
