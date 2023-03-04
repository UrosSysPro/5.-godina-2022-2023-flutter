// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:app/Card.dart' as app;
import 'package:app/CardEditPage.dart';
import 'package:flutter/cupertino.dart';
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
  var currentIndex=0;
  var theme=ThemeData.dark();
  var postValue="";
  List<String> lista=[];

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
          showAddMenu();
        },
        label: Row(
          children: [
            Icon(Icons.add),
            Text(
              "Add",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),
            )
          ],
        ),
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
            ListTile(
              leading:Icon(Icons.arrow_back),
              title: Text("item1"),
              selected: currentIndex==0,
              onTap: (){setState(() {
                currentIndex=0;
              });},
            ),
            ListTile(
              leading:Icon(Icons.arrow_forward),
              title: Text("item2"),
              selected: currentIndex==1,
              onTap: (){setState(() {
                currentIndex=1;
              });},
            ),
            ListTile(
              leading:Icon(Icons.sell),
              title: Text("item3"),
              selected: currentIndex==2,
              onTap: (){setState(() {
                currentIndex=2;
              });},
            ),
          ],
        ),
      ),

      body: Builder(
        builder: (context) {
          
          List<Widget> children=[];

          for(int i=0;i<lista.length;i++){
            children.add(
              app.Card(
                widget:Container(),
                title: lista[i],
                page: CardEditPage(lista,i),
              )
            );
          }

          children.addAll(
            [
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
                widget: CupertinoSwitch(
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
            ]
          );

          return ListView(
            children: children,
          );
        }
      )
    
    ));
  }


  void showAddMenu(){
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context){
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            height: 600,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30)
            ),
            child: Column(
              children: [
                Container(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "New Post",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30
                      ),
                    ),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Post",
                      border: OutlineInputBorder()
                    ),
                    onChanged: (value){
                      postValue=value;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: (){
                      setState(() {
                        if(postValue.length==0)return;
                        lista.add(postValue);
                        postValue="";
                        Navigator.pop(context);
                      });
                    },
                    child: Text("Post"),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}

//ui=build(state)