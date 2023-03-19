import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StartChatPage extends StatefulWidget {
  const StartChatPage({ Key? key }) : super(key: key);

  @override
  State<StartChatPage> createState() => _StartChatPageState();
}

class _StartChatPageState extends State<StartChatPage> {

  var db=FirebaseFirestore.instance;
  late Future<QuerySnapshot<Map<String, dynamic>>> future;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future=db.collection("users").get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
          
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          return Container();
        },
      ),
    );
  }
}