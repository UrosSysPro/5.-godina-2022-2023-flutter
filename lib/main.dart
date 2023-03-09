
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:app/primeriWidgeta/LoadingAnimation.dart';
// import 'package:app/primeriWidgeta/MainPage.dart';
// import 'package:flutter/material.dart';

// void main(){
//   runApp(
//     MaterialApp(
//       home: MainPage(),
//     )
//   );
// }

// import 'package:app/firestoreTest/AddUserPage.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:flutter/material.dart';

// Future<void> main() async{
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//     MaterialApp(
//       home: AddUserPage(),
//     )
//   );
// }


import 'package:app/whatsAppClone/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main(){
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.green
    ),
    debugShowCheckedModeBanner: false,
    home: MainPage(),
  ));
}