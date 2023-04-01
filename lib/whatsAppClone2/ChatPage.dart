import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  
  String uid1,uid2;
  User user;
  String chatId;
  
  ChatPage(this.uid1,this.uid2,this.user,this.chatId);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.uid1==widget.user.uid?widget.uid2:widget.uid1),
      ),
      // body: ,
    );
  }
}