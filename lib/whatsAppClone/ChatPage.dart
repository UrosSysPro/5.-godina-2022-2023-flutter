import 'package:app/whatsAppClone/Message.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back)
        ),
        title: Text("Ime"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Message(),Message(),
                Message(),
                Message(),
                Message(),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black26 
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(),
              ),
            ),
          )
        ],
      ),
    );
  }
}