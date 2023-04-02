import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String nickname,id,photoUrl;
  UserModel(this.nickname,this.photoUrl,this.id);


  @override
  String toString() {
    // TODO: implement toString
    return "$nickname $photoUrl $id";
  }

  static UserModel fromDoc(DocumentSnapshot<Map<String, dynamic>> doc){
    return UserModel(
      doc["nickname"],
      doc["photoUrl"],
      doc.id
    );
  }
}