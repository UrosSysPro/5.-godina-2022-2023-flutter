import 'package:app/firestoreTest/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserState with ChangeNotifier {
  static var db=FirebaseFirestore.instance;
  UserModel? userModel;
  UserState(User user){
    db.collection("users")
    .doc(user.uid)
    .snapshots().listen((event) { 
      
    });
  }
}