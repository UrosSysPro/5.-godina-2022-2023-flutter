import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  DateTime date;
  String text,userId,chatId,id;

  MessageModel({
    required this.id,
    required this.text,
    required this.chatId,
    required this.userId,
    required this.date,
  });

  static List<MessageModel> fromDocs(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs){
    List<MessageModel> list=[];

    for(var doc in docs){
      var json=doc.data();
      Timestamp t=json["time"];
      list.add(MessageModel(
        id: doc.id,
        text: json["text"],
        userId: json["userId"],
        chatId: json["chatId"],
        date: t.toDate()
      ));
    }

    return list;
  }
}