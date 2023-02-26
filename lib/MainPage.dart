import 'package:app/Card.dart' as app;
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  var key=GlobalKey<ScaffoldState>();
  var sliderValue=0.5;
  var switchValue=true;
  var textEditValue="";
  var theme=ThemeData.dark();

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: theme,
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
          app.Card(
            title:"Slider",
            widget: Slider(
              value: sliderValue,
              onChanged: (value){
                setState(() {
                  sliderValue=value;
                });
              },
            )
          ),
          app.Card(
            title: "Switch",
            widget: Switch(
              value: switchValue,
              onChanged: (value){
                setState(() {
                  if(value==true){
                    print("dark theme");
                    theme=ThemeData.dark();
                  }else{
                    print("light theme");
                    theme=ThemeData.light();
                  }
                  switchValue=value;
                });
              },
            )
          ),
          app.Card(title: "Text Field",widget: TextField()),
          app.Card(title: "Button",widget: ElevatedButton(child: Text("click"),onPressed: (){},))
        ],
      )
    
    ));
  }
}

//ui=build(state)