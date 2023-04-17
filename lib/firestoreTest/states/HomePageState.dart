import 'package:app/firestoreTest/models/ChatModel.dart';
import 'package:app/firestoreTest/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HomePageState with ChangeNotifier{
  static var db=FirebaseFirestore.instance;
  
  Map<String,UserModel> users={};

  void addIfDoesntExist(String uid){
    if(users[uid]==null){
      db.collection("users").doc(uid).get().then((value) {
        users[uid]=UserModel.fromDoc(value);
        notifyListeners();
        print(users[uid]);
      });
    }
  }
}