import 'package:app/whatsAppClone2/ChatModel.dart';
import 'package:app/whatsAppClone2/ChatPage.dart';
import 'package:app/whatsAppClone2/MainPage.dart';
import 'package:app/whatsAppClone2/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartChatPage extends StatefulWidget {
  
  UserModel user;
  
  StartChatPage(this.user);

  @override
  _StartChatPageState createState() => _StartChatPageState();
}

class _StartChatPageState extends State<StartChatPage> {
  var db = FirebaseFirestore.instance;

  ChatModel? chat;
  UserModel? other;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
        stream: db.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text(snapshot.error.toString()),
            );
          if (!snapshot.hasData)
            return Center(
              child: Text("loading..."),
            );
          if (snapshot.data == null)
            return Center(
              child: Text("nema nikog"),
            );
          var users = UserModel.fromDocs(snapshot.data!.docs);
          

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: SizedBox(
                  width: 30,
                  height: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: NetworkImage(
                        users[index].photoUrl,
                      ),
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.person);
                      },
                    ),
                  ),
                ),
                title: Text(users[index].nickname),
                onTap: (){
                  openChat(users[index]);
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<void> openChat(UserModel other) async{
    //proveri da li chat postoji
    var res=await db
      .collection("chats")
      .where("uids",arrayContains: widget.user.id)
      .get();
    var chats=ChatModel.fromDocs(res.docs);
    
    for(var chat in chats){
      if( (chat.uid1==other.id&&chat.uid2==widget.user.id)||
          (chat.uid2==other.id&&chat.uid1==widget.user.id)){
        navigatorKey.currentState?.pushReplacement(CupertinoPageRoute(builder: (context){
          return ChatPage(chat,widget.user,other);
        }));
        return;
      }
    }

    //ako ne postoji napravi novi
    var chatDocRef=await db.collection("chats").add(<String,dynamic>{
      "uids":[widget.user.id,other.id]
    });
    var chatDoc=await chatDocRef.get();
    var chat=ChatModel.fromDoc(chatDoc);
    navigatorKey.currentState?.pushReplacement(CupertinoPageRoute(builder: (context){
      return ChatPage(chat,widget.user,other);
    }));
  }
}
