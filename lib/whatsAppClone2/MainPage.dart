// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          body: StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return errorPage(snapshot.error!);
          if (snapshot.data == null) return signIn();
          return userInfoPage(snapshot.data!);
        },
      )),
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
        signInWithGoogle();
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
    var credentials =
        await auth.signInWithPopup(googleProvider);

    return credentials;
  }
}
