import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageSection extends StatelessWidget {
  String title,subtitle;
  String buttonText1,buttonText2;
  void Function()? onPressed1,onPressed2;
  bool dark;
  PageSection({
    required this.title,
    required this.subtitle,
    required this.buttonText1,
    required this.buttonText2,
    this.onPressed1,
    this.onPressed2,
    this.dark=true
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(bottom: 47),
      height: 580,
      color: dark?CupertinoColors.black:CupertinoColors.white,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          //image
          Padding(
            padding:EdgeInsets.only(top: 47),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: dark?CupertinoColors.white:CupertinoColors.black,
                    fontSize: 56,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: dark?CupertinoColors.white:CupertinoColors.black,
                    fontSize: 28,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      child: Text(
                        buttonText1,
                        style: TextStyle(
                          fontSize: 21
                        ),
                      ),
                      onPressed: onPressed1??(){},
                    ),
                    CupertinoButton(
                      child: Text(
                        buttonText2,
                        style: TextStyle(
                          fontSize: 21
                        ),
                      ),
                      onPressed: onPressed2??(){},
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}