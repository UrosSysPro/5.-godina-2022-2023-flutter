import 'package:app/whatsAppClone2/ChatModel.dart';
import 'package:app/whatsAppClone2/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  
  UserModel user;
  ChatModel chat;
  
  ChatPage(this.chat,this.user);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var messageText="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.chat.uid1==widget.user.id?widget.chat.uid2:widget.chat.uid1),
      ),
      body: Column(
        children: [
          Expanded(child: ListView(),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 19, 19, 19),
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.emoji_emotions),
                        Expanded(
                          child: TextField(
                            decoration: null,
                            style: TextStyle(
                              fontSize: 20
                            ),
                            onChanged: (value){
                              messageText=value;
                            },
                          ),
                        ),
                        Icon(Icons.attachment),
                        Icon(Icons.photo),
                      ],
                    ),
                  )
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 10),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).primaryColor
                    ),
                    child: IconButton(
                      splashRadius: 1,
                      icon: Icon(Icons.send,size: 20,),
                      onPressed: (){
                        
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}