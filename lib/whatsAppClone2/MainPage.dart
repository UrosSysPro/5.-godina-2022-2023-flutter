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
