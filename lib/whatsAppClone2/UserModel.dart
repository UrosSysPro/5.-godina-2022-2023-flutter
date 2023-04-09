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
    var json=doc.data();
    if(json==null){
      return UserModel("???","???",doc.id);
    }
    return UserModel(
      json["nickname"]??"??? ???",
      json["photoUrl"]??"??? ???",
      doc.id
    );
  }
}