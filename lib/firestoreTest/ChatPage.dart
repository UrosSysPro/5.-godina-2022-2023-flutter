import 'package:app/firestoreTest/models/ChatModel.dart';
import 'package:app/firestoreTest/models/MessageModel.dart';
import 'package:app/firestoreTest/MessageView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  User user;
  ChatModel chat;
  ChatPage(this.user,this.chat);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  var db=FirebaseFirestore.instance;
  late TextEditingController controller;

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
          icon:Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.user.uid==widget.chat.uids[0]?
          widget.chat.uids[1]:widget.chat.uids[0]
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: db.collection("messages")
              .where("chatId",isEqualTo: widget.chat.id).snapshots(),
              builder: (context,snapshot){
                if(snapshot.hasError)return Container(color:Colors.red);
                if(!snapshot.hasData)return Center(child: Text("loading..."),);
                
                var messages=MessageModel.fromDocs(snapshot.data!.docs);
                messages.sort((m1,m2){
                  var t1=m1.date.millisecondsSinceEpoch;
                  var t2=m2.date.millisecondsSinceEpoch;
                  return t1>t2?1:-1;
                });

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context,index){
                    // return Text(messages[index].text);
                    return MessageView(widget.user, messages[index]);
                  },
                );
              },
            ) 
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,horizontal: 10
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).primaryColor
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.emoji_emotions),
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextField(
                            controller: controller,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                            ),
                            decoration: null,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Icon(Icons.attachment),
                        SizedBox(width: 10,),
                        Icon(Icons.photo)
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8,),
                Container(
                  width: 40,height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: (){
                      if(controller.text.isNotEmpty){
                        db.collection("messages").add(<String,dynamic>{
                          "chatId":widget.chat.id,
                          "userId":widget.user.uid,
                          "text":controller.text,
                          "time":DateTime.now()
                        });
                        setState(() {
                          controller.text="";
                        });
                      }
                    },
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