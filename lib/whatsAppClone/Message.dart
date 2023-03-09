import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(200, 5, 5, 5),
      child: Container(
        width: 100,
        child: Text("this is message\nthis is message\nthis is message\nthis is message\nthis is message\nthis is message\nthis is message\nthis is message\nthis is message\nthis is message\nthis is message\nthis is message\n"),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}