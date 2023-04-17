import 'package:app/firestoreTest/models/ChatModel.dart';
import 'package:app/firestoreTest/StartChatPage.dart';
import 'package:app/firestoreTest/ChatPage.dart';
import 'package:app/firestoreTest/states/HomePageState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: chatList(),
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



  Widget chatList() {
    return StreamBuilder(
      stream: chatsRef
                .where("uids",arrayContains: widget.user.uid)
                .snapshots(),
      builder: ((context, snapshot) {
        if(snapshot.hasError)return Container(color: Colors.red,);
      
        if(!snapshot.hasData)return Center(child: Text("loading..."),);

        var chats=ChatModel.fromDoc(snapshot.data!.docs); 
        
        for(var chat in chats){
          context.read<HomePageState>().addIfDoesntExist(
            chat.uids[0]!=widget.user.uid?chat.uids[0]:chat.uids[1]
          );
        }

        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context,index){
            var chat=chats[index];
            String otherUid=chat.uids[0]!=widget.user.uid?chat.uids[0]:chat.uids[1];
            return ListTile(
              leading: Icon(Icons.person),
              title: Text(chats[index].uids[0]),
              subtitle: Text(chats[index].uids[1]),
              onTap: (){
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context){
                      
                      return ChatPage(widget.user,chats[index]);
                    }
                  )
                );
              },
            );
          },
        );
      }),
    );
  }
}