import 'package:app/firestoreTest/models/ChatModel.dart';
import 'package:app/firestoreTest/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage{
  static var db=FirebaseFirestore.instance;
  
  List<ChatModel> chats=[];
  Map<String,UserModel> users={};

  HomePage(UserModel user){
    var sub=db.collection("chats").where("uids",arrayContains: user.uid).snapshots().listen((event) { 
      chats=ChatModel.fromDoc(event.docs);
    });
  }
}