
import 'package:flutter/material.dart';


void main(){
  var key=GlobalKey<ScaffoldState>();

  runApp(MaterialApp(
    theme: ThemeData.dark(),
    title: "App",
    home: Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("App bar"),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            key.currentState!.openDrawer();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          print("click");
        },
        label: Text("Add")
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            Text("eee"),
            Text("eee"),
            Text("eee"),
            Text("eee"),
            Text("eee"),
          ],
        ),
      ),

      body: ListView(
        children: [
           Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 600,
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(50)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 600,
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(50)
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 600,
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(50)
              ),
            ),
          ),
        ],
      )
    )
  ));
}