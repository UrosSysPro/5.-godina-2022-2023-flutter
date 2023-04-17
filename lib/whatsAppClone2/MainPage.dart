// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:app/whatsAppClone2/HomePage.dart';
import 'package:app/whatsAppClone2/UsersState.dart';
import 'package:app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

var navigatorKey = GlobalKey<NavigatorState>();

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

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    auth.setPersistence(Persistence.LOCAL);
    FirebaseMessaging messaging = FirebaseMessaging.instance;

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
    var vapid =
        "BA6u_Mioay2qHBjc8Zf3l8rBbSp1R2yQm0bdrKRwroQCSTxa4K8QyT_nVh4LspvNzx5lX6_T-kfKfRsUO1_YmoU";
    messaging.getToken(vapidKey: vapid).then((value) {
      print(value);
    });
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessage);
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UsersState(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
            body: StreamBuilder(
          stream: auth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return errorPage(snapshot.error!);
            // if(!snapshot.hasData)return Center(child: Text("loading..."),);
            if (snapshot.data == null) return signIn();
            return HomePage(snapshot.data!);
          },
        )),
      ),
    );
  }

  Widget errorPage(Object error) {
    return Center(
      child: Text(error.toString()),
    );
  }

  Widget signIn() {
    return Center(
        child: ElevatedButton(
      child: Text("Sign in"),
      onPressed: () {
        if (kIsWeb) {
          signInWithGoogle();
          return;
        }
        if (Platform.isAndroid) {
          signInWithGoogleAndroid();
          return;
        }
      },
    ));
  }

  Widget userInfoPage(User user) {
    return Column(
      children: [
        Text(user.uid),
        Text(user.displayName ?? "Nema user name"),
        Text(user.email ?? "nema mail"),
        Image(image: NetworkImage(user.photoURL!)),
        ElevatedButton(
          child: Text("Sign out"),
          onPressed: () {
            auth.signOut();
          },
        )
      ],
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    var credentials = await auth.signInWithPopup(googleProvider);

    return credentials;
  }

  Future<UserCredential> signInWithGoogleAndroid() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
