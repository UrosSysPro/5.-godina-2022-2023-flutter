import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String nickName;
  String uid;
  UserModel(this.nickName,this.uid);

  static List<UserModel> fromDoc(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs){
    List<UserModel> list=[];

    for(var doc in docs){
      list.add(UserModel(
        doc["nickname"]??"Nema nadimak",
        doc.id
      ));
    }

    return list;
  }
}