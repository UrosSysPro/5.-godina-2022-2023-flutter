import 'package:app/firestoreTest/ChatModel.dart';
import 'package:app/firestoreTest/StartChatPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  User user;
  HomePage({ Key? key,required this.user }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var chatsRef=FirebaseFirestore.instance.collection("chats");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        actions: [
          IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout)
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(20),
          //     child: Image(
          //       image: NetworkImage(widget.user.photoURL!),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // )
        ],
      ),
      body: StreamBuilder(
        stream: chatsRef
                  .where("uids",arrayContains: widget.user.uid)
                  .snapshots(),
        builder: ((context, snapshot) {
          if(snapshot.hasError)return Container(color: Colors.red,);
          if(!snapshot.hasData)return Container(color:Colors.white);
          
          List<ChatModel> chats=ChatModel.fromDoc(snapshot.data!.docs);

          if(chats.length==0){
            return Center(
              child: Text("zapocni neki razgovor"),
            );
          }
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context,index){
              return Column(
                children: [
                  Text(snapshot.data!.docs[index]["uids"][0]),
                  Text(snapshot.data!.docs[index]["uids"][1]),
                ],
              );
            }
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.chat),
        label: Text("Start chat"),
        onPressed: (){
          Navigator.push(context, 
          MaterialPageRoute(builder: (context){
            return StartChatPage();
          }));
        },
      ),
    );
  }
}