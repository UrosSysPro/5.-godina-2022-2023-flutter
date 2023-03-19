import 'package:app/firestoreTest/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Sign in",
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.error != null) return errorPage(snapshot.error);
              if (snapshot.data == null) return signInPage();
              return HomePage(user:snapshot.data!);
            },
          ),
        ));
  }

  Widget errorPage(Object? error) {
    return Center(
      child: Text(error!.toString()),
    );
  }

  Widget signInPage() {
    return Center(
      child: ElevatedButton(
        child: Text("Sign In"),
        onPressed: () {
          signInWithGoogle();
        },
      ),
    );
  }

  Widget userInfoPage(User user) {
    return Center(
      child: Column(
        children: [
          Text(user.email ?? "Nema mail"),
          Text(user.uid),
          Text(user.displayName ?? "nema display name"),
          
        ],
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    var credentials= await FirebaseAuth.instance.signInWithPopup(googleProvider);
    
    if(credentials.user!=null){

      FirebaseFirestore.instance
        .collection("users")
        .doc(credentials.user!.uid).set(<String,dynamic>{
          "nickname":credentials.user!.displayName??"nema nadimak:("
        });
    }
   

    return credentials;
    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }
}
