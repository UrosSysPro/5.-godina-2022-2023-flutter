import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({ Key? key }) : super(key: key);

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {

  var db=FirebaseFirestore.instance;
  var username="";
  var password="";
  var email="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value){
                username=value;
              },
              decoration: InputDecoration(
                labelText: "username",
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              onChanged: (value){
                email=value;
              },
              decoration: InputDecoration(
                labelText: "e-mail",
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              onChanged: (value){
                password=value;
              },
              decoration: InputDecoration(
                labelText: "password",
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              child: Text("Add"),
              onPressed: (){
                var user=<String,dynamic>{
                  "username":username,
                  "password":password,
                  "email":email
                };
                db.collection("users").add(user).then((value) => print("user added with id: $value"));
              },
            ),
          ],
        ), 
      ),
    );
  }
}