
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
            SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Header",
                style: TextStyle(fontSize: 30),
              ),
            ),
            ListTile(leading:Icon(Icons.home),title: Text("item1"),),
            ListTile(leading:Icon(Icons.search),title: Text("item2"),selected: true,),
            ListTile(leading:Icon(Icons.sell),title: Text("item3"),),
          ],
        ),
      ),

      body: ListView(
        children: [
          card("Slider", Slider(value: 0.5,onChanged: (value){},)),
          card("Switch", Switch(value: true,onChanged: (value){},)),
          card("Text Edit", TextField()),
          card("Button",ElevatedButton(child: Text("click"),onPressed: (){},))
        ],
      )
    )
  ));
}


Widget card(String title,Widget widget){
  return Padding(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
            child: new Container(
              width: 10000,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ThemeData.dark().scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2,2),
                    blurRadius: 2,
                    spreadRadius: 3
                  )
                ]
              ),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                      style: TextStyle(
                        fontSize: 35
                      )
                    ),
                    SizedBox(
                      width: 300,
                      child: widget,
                    )
                  ],
                ),
              ),
            ),
  );
}