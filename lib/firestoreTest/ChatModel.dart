import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel{
  List<String> uids;
  ChatModel(this.uids);

  static List<ChatModel> fromDoc(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs){
    List<ChatModel> list=[];

    for(var doc in docs){
      var data=doc.data();
      list.add(ChatModel([
        data["uids"][0],
        data["uids"][1]
      ]));
    }

    return list;
  }
}