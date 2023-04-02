import 'package:app/firestoreTest/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SetupAccount extends StatefulWidget {
  User user;
  SetupAccount({required this.user});

  @override
  _SetupAccountState createState() => _SetupAccountState();
}

class _SetupAccountState extends State<SetupAccount> {
  var db=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.collection("users").doc(widget.user.uid).snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasError)return Container(color: Colors.red,);
        if(!snapshot.hasData)return Center(child: Text("loading..."),);
        if(snapshot.data!.data()==null){
          db.collection("users").doc(widget.user.uid).set(<String,dynamic>{
            "nickname":widget.user.displayName,
            "photoUrl":widget.user.photoURL,
          });
          return Container(color: Colors.orange,);
        }
        return HomePage(user:widget.user);
      },
    );
  }
}