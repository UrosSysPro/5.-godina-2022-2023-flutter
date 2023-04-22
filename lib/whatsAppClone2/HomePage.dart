import 'dart:async';

import 'package:app/whatsAppClone2/StartChatPage.dart';
import 'package:app/whatsAppClone2/ChatModel.dart';
import 'package:app/whatsAppClone2/UserModel.dart';
import 'package:app/whatsAppClone2/ChatPage.dart';
import 'package:app/whatsAppClone2/UsersState.dart';
import 'package:app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


@pragma('vm:entry-point')
Future<void> _onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print(message.data);
  print(message.notification?.title);
  print(message.notification?.body);
  print(message.senderId);
  print(message.messageType);
}

void _onMessage(RemoteMessage message) {
  print(message.data);
  print(message.notification?.title);
  print(message.notification?.body);
  print(message.senderId);
  print(message.messageType);
}

var vapid =
        "BA6u_Mioay2qHBjc8Zf3l8rBbSp1R2yQm0bdrKRwroQCSTxa4K8QyT_nVh4LspvNzx5lX6_T-kfKfRsUO1_YmoU";
   

class HomePage extends StatefulWidget {
  User user;
  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var db = FirebaseFirestore.instance;
  var messaging=FirebaseMessaging.instance;
  late DocumentReference<Map<String, dynamic>> myDocRef;

  late StreamSubscription<RemoteMessage> onMessageSubscription;
  late StreamSubscription<RemoteMessage> onMessageOpenSubscription;
  late StreamSubscription<String> onMessagingTokenRefresh;
  @override
  void initState() {
    super.initState();
    myDocRef = db.collection("users").doc(widget.user.uid);
    messaging.getNotificationSettings().then((value) {
      if(value.authorizationStatus!=AuthorizationStatus.authorized){
        messaging
        .requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    )
        .then((setting) {
      print('User granted permission: ${setting.authorizationStatus}');
    });
      }
    });
    
    messaging.getToken(vapidKey: vapid).then((value) {
      try{
        myDocRef.update(<String,dynamic>{
          "messagingId":value
        });
      }catch(e,stackTrace){
        print(stackTrace);
      }
      print(value);
    });

    onMessagingTokenRefresh=messaging.onTokenRefresh.listen((event) {print(event);});
    onMessageSubscription=FirebaseMessaging.onMessageOpenedApp.listen(_onMessage);
    onMessageOpenSubscription=FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  }
  @override
  void dispose() {
    super.dispose();

    onMessageOpenSubscription.cancel();
    onMessageSubscription.cancel();
    onMessagingTokenRefresh.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: myDocRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Container(
            color: Colors.red,
          );
        if (!snapshot.hasData)
          return Center(
            child: Text("Loading..."),
          );
        var data=snapshot.data;
        var json=data?.data();
        if (data==null||json==null||json["nickname"]==null||json["photoUrl"]==null){
          //ako se ucita a user ne postoji
          //setup user
          myDocRef.set(<String, dynamic>{
            "nickname": widget.user.displayName,
            "photoUrl": widget.user.photoURL,
          });
          return Container(
            color: Colors.orange,
          );
        }
        
        var userInfo = UserModel.fromDoc(snapshot.data!);
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
                      userInfo.photoUrl
                    ),
                    fit: BoxFit.cover,
                    errorBuilder: (context,error,stackTrace){
                      return Icon(Icons.person);
                    },
                  ),
                ),
              )
            ],
          ),
          body: chatList(userInfo),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.chat),
            label: Text("Start Chat"),
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return StartChatPage(userInfo);
              }));
            },
          ),
        );
      },
    );
  }

  Widget chatList(UserModel userInfo) {
    return StreamBuilder(
      stream: db
          .collection("chats")
          .where("uids", arrayContains: widget.user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Container(
            color: Colors.red,
          );
        if (!snapshot.hasData)
          return Center(
            child: Text("Loading..."),
          );
        var chats = ChatModel.fromDocs(snapshot.data!.docs);

        for(var chat in chats){
          context.read<UsersState>().checkIfExists(
            chat.uid1==userInfo.id?chat.uid2:chat.uid1
          );
        }

        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            String uid1 = chats[index].uid1;
            String uid2 = chats[index].uid2;
            String othersId=uid1==userInfo.id?uid2:uid1;
            UserModel? other=context.watch<UsersState>().users[othersId];
            // print(other?.toString());
            return ListTile(
              leading: SizedBox(
                width: 30,height: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image(
                    image: NetworkImage(other?.photoUrl??"nema",),
                    errorBuilder: (context,error,stackTrace){
                      return Icon(Icons.person);
                    },
                  ),
                ),
              ),
              title: Text(other?.nickname??"nema"),
              // subtitle: Text(uid2),
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return ChatPage(chats[index], userInfo,other);
                }));
              },
            );
          },
        );
      },
    );
  }
}
