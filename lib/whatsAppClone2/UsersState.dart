import 'package:app/whatsAppClone2/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UsersState with ChangeNotifier {
  var db=FirebaseFirestore.instance;
  Map<String,UserModel> users={};

  void checkIfExists(String uid){
    if(users[uid]==null){
      db.collection("users").doc(uid).get().then(
        (value) {
          users[uid]=UserModel.fromDoc(value);
          notifyListeners();
        }
      );

      // print("eee");
    }
  }
}