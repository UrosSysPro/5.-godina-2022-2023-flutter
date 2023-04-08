import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  String text,chatId,userId,messageId;
  Timestamp time;
  MessageModel({
    required this.text,
    required this.chatId,
    required this.userId,
    required this.time,
    required this.messageId
  });

  static List<MessageModel> fromDocs(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs){
    List<MessageModel> list=[];

    for(var doc in docs){
      var json=doc.data();
      list.add(MessageModel(
        text: json["text"],
        chatId: json["chatId"],
        userId: json["userId"],
        time:json["time"],
        messageId: doc.id
      ));
    }

    return list;
  }
}