import 'package:cloud_firestore/cloud_firestore.dart';
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
          int n=snapshot.data!.docs.length;
          if(n==0)return Center(
            child: Text("nema nikog"),
          );
          return ListView.builder(
            itemCount: n,
            itemBuilder: (context,index){
              return ListTile(
                leading: Icon(Icons.person),
                title: Text( snapshot.data!.docs[index]["nickname"]),
              );
            },
          );
        },
      )
    );
  }
}