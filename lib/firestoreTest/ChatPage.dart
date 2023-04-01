import 'package:app/firestoreTest/ChatModel.dart';
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
                List<String> messages=[];
                for(var doc in snapshot.data!.docs){
                  messages.add(doc.data()["text"]);
                }
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context,index){
                    return Text(messages[index]);
                  },
                );
              },
            ) 
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,horizontal: 20
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                      ),
                      decoration: null,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      db.collection("messages").add(<String,dynamic>{
                        "chatId":widget.chat.id,
                        "text":"yoo"
                      });
                    },
                    child: Icon(Icons.send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}