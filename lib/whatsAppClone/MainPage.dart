import 'package:app/whatsAppClone/Chat.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.photo)),
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: Icon(Icons.settings)),
          SizedBox(width: 10,)
        ],
      ),
      body: ListView(
        children: [
          Chat(),
          Chat(),
          Chat(),
          Chat(),
          Chat(),
          Chat(),
          Chat(),
          Chat(),
          Chat(),
          Chat(),
          Chat(),
          Chat(),
        ],
      ),
    );
  }
}