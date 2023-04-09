
import 'package:app/whatsAppClone2/ChatModel.dart';
import 'package:app/whatsAppClone2/MessageModel.dart';
import 'package:app/whatsAppClone2/MessageView.dart';
import 'package:app/whatsAppClone2/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  
  UserModel user;
  UserModel? other;
  ChatModel chat;
  
  ChatPage(this.chat,this.user,this.other);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController controller;
  var db=FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.other?.nickname??"Loading..."),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: db.collection("messages")//.orderBy("time")
              .where("chatId",isEqualTo: widget.chat.id).orderBy("time").limit(100)
              .snapshots(),
              builder: (context,snapshot){
                if(snapshot.hasError)return Container(color: Colors.red,);
                if(!snapshot.hasData)return Center(child: Text("Loading..."),);
                
                var messages=MessageModel.fromDocs(snapshot.data!.docs);

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context,index){
                    return MessageView(
                      message: messages[index],
                      user:widget.user
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 19, 19, 19),
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.emoji_emotions),
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextField(
                            controller: controller,
                            decoration: null,
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Icon(Icons.attachment),
                        SizedBox(width: 10,),
                        Icon(Icons.photo),
                        SizedBox(width: 10,),
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
                        if(controller.text.isNotEmpty){
                          var t=Timestamp.fromDate(DateTime.now());
                          db.collection("messages").add(<String,dynamic>{
                            "chatId":widget.chat.id,
                            "text":controller.text,
                            "time":t,
                            "userId":widget.user.id
                          });
                          controller.text="";
                        }
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