import 'package:app/firestoreTest/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StartChatPage extends StatefulWidget {
  const StartChatPage({ Key? key }) : super(key: key);

  @override
  State<StartChatPage> createState() => _StartChatPageState();
}

class _StartChatPageState extends State<StartChatPage> {

  var userRef=FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: StreamBuilder(
        stream: userRef.snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasError)return Container(color: Colors.red,);
          if(!snapshot.hasData)return Container(color: Colors.white,);
          
          var users=UserModel.fromDoc(snapshot.data!.docs);

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context,index){
              return ListTile(
                onTap: (){
                  FirebaseFirestore.instance.collection("chats").add(<String,dynamic>{
                    "uids":[
                      users[index].uid,
                      FirebaseAuth.instance.currentUser!.uid
                    ]
                  });
                  Navigator.pop(context);
                },
                leading: Icon(Icons.person),
                title: Text(users[index].nickName),
              );
            },
          );
        },
      )
    );
  }
}