import 'dart:async';

import 'package:app/whatsAppClone2/ChatListPage.dart';
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

// void _onMessage(RemoteMessage message) {
//   print(message.data);
//   print(message.notification?.title);
//   print(message.notification?.body);
//   print(message.senderId);
//   print(message.messageType);
// }
// void _onMessageOpened(RemoteMessage message){
//   print(message.data);
//   print(message.notification?.title);
//   print(message.notification?.body);
//   print(message.senderId);
//   print(message.messageType);
// }

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
  var messaging = FirebaseMessaging.instance;
  late DocumentReference<Map<String, dynamic>> myDocRef;

  late StreamSubscription<RemoteMessage> onMessageSubscription;
  late StreamSubscription<RemoteMessage> onMessageOpenSubscription;
  late StreamSubscription<String> onMessagingTokenRefresh;
  @override
  void initState() {
    super.initState();
    myDocRef = db.collection("users").doc(widget.user.uid);
    setUpNotifications();
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
        var data = snapshot.data;
        var json = data?.data();
        if (data == null ||
            json == null ||
            json["nickname"] == null ||
            json["photoUrl"] == null) {
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
        return ChatListPage(userInfo);
      },
    );
  }

  Future<void> setUpNotifications() async {
    var settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      print("Authorized with settings ${settings.authorizationStatus}");
    }

    var token = await messaging.getToken(vapidKey: vapid);
    try {
      myDocRef.update(<String, dynamic>{"messagingId": token});
    } catch (e, stackTrace) {
      print(e);
    }
    print(token);

    onMessagingTokenRefresh = messaging.onTokenRefresh.listen((event) {
      print(event);
    });
    onMessageSubscription =
        FirebaseMessaging.onMessageOpenedApp.listen((message){
          print(message.data);
          print(message.notification?.title);
          print(message.notification?.body);
        });
    onMessageOpenSubscription = FirebaseMessaging.onMessage.listen((message){
          print(message.data);
          print(message.notification?.title);
          print(message.notification?.body);
        });
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  }
}
