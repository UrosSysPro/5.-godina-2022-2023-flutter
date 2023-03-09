import 'package:app/whatsAppClone/ChatPage.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return ChatPage();
          })
        );
      },
      child: Container(
        height: 90,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              FlutterLogo(
                size: 50,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ime",
                      style: TextStyle(
                        fontSize: 25
                      ),
                    ),
                    Text(
                      "poruka",
                      style: TextStyle(
                        
                        color: Colors.black26
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Text("16:34"),
                  Container(
                    width: 20,height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(child: Text("1")),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}