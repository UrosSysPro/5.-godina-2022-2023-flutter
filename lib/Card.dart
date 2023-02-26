import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  late Widget widget;
  late String title;

  Card({ Key? key, required this.widget, required this.title  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
            child: new Container(
              width: 10000,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).scaffoldBackgroundColor,
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
}