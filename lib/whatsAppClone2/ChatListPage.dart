import 'package:app/whatsAppClone2/ChatModel.dart';
import 'package:app/whatsAppClone2/ChatPage.dart';
import 'package:app/whatsAppClone2/SettingsPage.dart';
import 'package:app/whatsAppClone2/StartChatPage.dart';
import 'package:app/whatsAppClone2/UserModel.dart';
import 'package:app/whatsAppClone2/UsersState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatListPage extends StatefulWidget {
  UserModel userInfo;
  ChatListPage(this.userInfo);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {


  var db = FirebaseFirestore.instance;
  var messaging = FirebaseMessaging.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Messages"),
            actions: [
              GestureDetector(
                onTap: ()=>Navigator.push(context, CupertinoPageRoute(builder: (context){
                  return SettingsPage(widget.userInfo);
                })),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: NetworkImage(widget.userInfo.photoUrl),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.person);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          body: chatList(widget.userInfo),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.chat),
            label: Text("Start Chat"),
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return StartChatPage(widget.userInfo);
              }));
            },
          ),
        );
  }


  Widget chatList(UserModel userInfo) {
    return StreamBuilder(
      stream: db
          .collection("chats")
          .where("uids", arrayContains: widget.userInfo.id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Container(
            color: Colors.red,
          );
        if (!snapshot.hasData)
          return Center(
            child: Text("Loading..."),
          );
        var chats = ChatModel.fromDocs(snapshot.data!.docs);

        for (var chat in chats) {
          context
              .read<UsersState>()
              .checkIfExists(chat.uid1 == userInfo.id ? chat.uid2 : chat.uid1);
        }

        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            String uid1 = chats[index].uid1;
            String uid2 = chats[index].uid2;
            String othersId = uid1 == userInfo.id ? uid2 : uid1;
            UserModel? other = context.watch<UsersState>().users[othersId];
            // print(other?.toString());
            return ListTile(
              leading: SizedBox(
                width: 30,
                height: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image(
                    image: NetworkImage(
                      other?.photoUrl ?? "nema",
                    ),
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.person);
                    },
                  ),
                ),
              ),
              title: Text(other?.nickname ?? "nema"),
              // subtitle: Text(uid2),
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return ChatPage(chats[index], userInfo, other);
                }));
              },
            );
          },
        );
      },
    );
  }
}