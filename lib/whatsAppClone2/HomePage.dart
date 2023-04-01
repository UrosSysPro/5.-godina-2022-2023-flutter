import 'package:app/whatsAppClone2/ChatPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  User user;
  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var db=FirebaseFirestore.instance;
  late DocumentReference<Map<String,dynamic>> myDocRef;
  @override
  void initState() {
    myDocRef=db.collection("users").doc(widget.user.uid);
  }
  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder(
      stream: myDocRef.snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasError)return Container(color: Colors.red,);
        if(!snapshot.hasData){
          //loading
          return Container(color: Colors.blue,);
        }
        if(snapshot.data!.data()==null){
          //ako se ucita a user ne postoji
          //setup user
          myDocRef.set(<String,dynamic>{
            "nickname":widget.user.displayName,
            "photoUrl":widget.user.photoURL,
          });
          return Container(color: Colors.blue,);
        }
        var userInfo=snapshot.data!.data()!;
        // print(userInfo!["nickname"]);
        // print(userInfo["photoUrl"]);
        //chat
        return Scaffold(
          appBar: AppBar(
            title: Text("Messages"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: NetworkImage(
                      userInfo["photoUrl"]
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          body: StreamBuilder(
            stream: db.collection("chats")
            .where("uids",arrayContains: widget.user.uid)
            .snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasError)return Container(color: Colors.red,);
              if(!snapshot.hasData)return Center(child: Text("Loading..."),);
              var docs=snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context,index){
                  String uid1= docs[index]["uids"][0];
                  String uid2= docs[index]["uids"][1];
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(uid1),
                    subtitle: Text(uid2),
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context){
                        return ChatPage(uid1,uid2,widget.user,docs[index].id);
                      }));
                    },
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.chat),
            label: Text("Start Chat"),
            onPressed: (){
              Navigator.push(context, CupertinoPageRoute(builder: (context){
                return Container(color: Colors.cyan,);
              }));
            },
          ),
        );
      },
    );
  }
}