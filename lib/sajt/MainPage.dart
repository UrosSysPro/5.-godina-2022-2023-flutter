import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sajt",
      home: Scaffold(
        body: ListView(
          children: [
            AppBar(
              title: Text("naslov"),
              backgroundColor: Colors.white,
            ),
            SizedBox(
              height: 500,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Container(color: Color(0xffd4e9e2)),
              ),
            ),
            SizedBox(
              height: 500,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(child:Container(color: Color(0xff006241))),
                    Expanded(child:Container(color: Color(0xffd4e9e2))),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 500,
            ),
          ],
        ),
      ),
    );
  }
}