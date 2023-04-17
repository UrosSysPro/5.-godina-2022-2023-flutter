import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String nickName;
  String uid;
  UserModel(this.nickName,this.uid);

  static List<UserModel> fromDocs(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs){
    List<UserModel> list=[];

    for(var doc in docs){
      list.add(UserModel(
        doc["nickname"]??"Nema nadimak",
        doc.id
      ));
    }

    return list;
  }
  static UserModel fromDoc(DocumentSnapshot<Map<String, dynamic>> doc){
    var json=doc.data();
    if(json==null){
      return UserModel(
        "???",
        doc.id
      );
    }
    return UserModel(
      json["nickname"]??"???",
      doc.id
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "nickname: $nickName uid: $uid";
  }
}