import 'package:app/whatsAppClone2/MainPage.dart';
import 'package:app/whatsAppClone2/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsPage extends StatefulWidget {
  UserModel user;
  SettingsPage(this.user);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(widget.user.nickname),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50,left: 50,bottom: 50),
            child: SizedBox(
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(400),
                child: Image(
                  image: NetworkImage(widget.user.photoUrl),
                  errorBuilder: (context,e,stackTrace){
                    return Icon(Icons.person);
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          OutlinedButton(
            onPressed: ()async{
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              navigatorKey.currentState?.pop();
            }, 
            child: Text("Log out")
          )
        ],
      ),
    );
  }
}