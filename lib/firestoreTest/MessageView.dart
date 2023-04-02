import 'package:app/firestoreTest/MessageModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  User user;
  MessageModel message;
  
  MessageView(this.user,this.message);

  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 1,
      alignment: user.uid==message.userId?
        Alignment.centerRight:Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: user.uid==message.userId?Colors.green:Colors.black,
            borderRadius: BorderRadius.circular(4)
          ),
          child: Text(message.text),
        ),
      ),
    );
  }
}