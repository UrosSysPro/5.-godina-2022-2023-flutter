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
          )
        ],
      ),
      body: StreamBuilder(
        stream: chatsRef
                  .where("uids",arrayContains: widget.user.uid)
                  .snapshots(),
        builder: ((context, snapshot) {
          if(snapshot.hasError)return Container(color: Colors.red,);
          if(!snapshot.hasData)return Container(color:Colors.white);
          
          for(var doc in snapshot.data!.docs){
            print(doc.id);
            print(doc["uids"][0]);
            print(doc["uids"][1]);
          }
          var n=snapshot.data!.docs.length;
          print(n);

          if(n==0){
            return Center(
              child: Text("zapocni neki razgovor"),
            );
          }

          return ListView.builder(
            itemCount: n,
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