import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel{
  List<String> uids;
  ChatModel(this.uids);

  static List<ChatModel> fromDoc(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs){
    List<ChatModel> list=[];

    for(var doc in docs){
      list.add(ChatModel(doc["uids"]));
    }

    return list;
  }
}