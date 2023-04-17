import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel{
  String uid1,uid2,id;

  ChatModel(this.uid1,this.uid2,this.id);

  static List<ChatModel> fromDocs(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs){
    List<ChatModel> list=[];

    for(var doc in docs){
      var json=doc.data();
      list.add(ChatModel(
        json["uids"][0],
        json["uids"][1],
        doc.id,
      ));
    }

    return list;
  }

  static ChatModel fromDoc(DocumentSnapshot<Map<String, dynamic>> doc){
    var json=doc.data()!;
    return ChatModel(json["uids"][0],json["uids"][1],doc.id);
  }
}