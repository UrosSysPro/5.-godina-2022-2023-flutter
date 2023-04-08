import 'package:app/firestoreTest/MessageView.dart';
import 'package:app/whatsAppClone2/MessageModel.dart';
import 'package:app/whatsAppClone2/UserModel.dart';
import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  late MessageModel message;
  late UserModel user;

  MessageView({
    required this.message,
    required this.user
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 1,
      alignment: user.id==message.userId?Alignment.centerRight:Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2,horizontal:4),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: user.id==message.userId?Colors.green:Colors.black
          ),
          child: Text(
            message.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
        ),
      ),
    );
  }
}