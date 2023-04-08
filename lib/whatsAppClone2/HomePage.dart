import 'package:app/whatsAppClone2/ChatModel.dart';
import 'package:app/whatsAppClone2/UserModel.dart';
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
          return Center(child: Text("Loading..."),);
        }
        if(snapshot.data!.data()==null){
          //ako se ucita a user ne postoji
          //setup user
          myDocRef.set(<String,dynamic>{
            "nickname":widget.user.displayName,
            "photoUrl":widget.user.photoURL,
          });
          return Container(color: Colors.orange,);
        }
        var userInfo=UserModel.fromDoc(snapshot.data!);
        print(userInfo);
        // print(userInfo!["nickname"]);
        // print(userInfo["photoUrl"]);
        //chat
        return Scaffold(
          appBar: AppBar(
            title: Text("Messages"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(20),
                //   child: Image(
                //     image: NetworkImage(
                //       userInfo.photoUrl
                //     ),
                //     fit: BoxFit.cover,
                //   ),
                // ),
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
              var chats=ChatModel.fromDocs(snapshot.data!.docs);
              
              return ListView.builder(
                itemCount:chats.length,
                itemBuilder: (context,index){
                  String uid1= chats[index].uid1;
                  String uid2= chats[index].uid2;
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(uid1),
                    subtitle: Text(uid2),
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context){
                        return ChatPage(chats[index],userInfo);
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