import 'dart:math';

import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  var width=4;
  var height=4;
  var cellSize=100;
  List<List<double>> mat=[];
  var selectedRow=0;
  var selectedColumn=0;
  double columnDelta=0;
  double rowDelta=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<width;i++){
      mat.add([]);
      for(int j=0;j<height;j++){
        mat[i].add(i+j*width+1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Animacija",
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onVerticalDragStart: (event){
              selectedColumn=event.localPosition.dx~/cellSize;
            },
            onVerticalDragUpdate: (event){
              // print("vertical ${event.delta}");
              setState(() {
                columnDelta+=event.delta.dy;
              });
            },
            onVerticalDragEnd: (event){
              setState(() {
                selectedColumn=-1;
                columnDelta=0;
              });
             
            },
            onHorizontalDragStart:  (event){
              selectedRow=event.localPosition.dy~/cellSize;
            },
            onHorizontalDragUpdate: (event){
              setState(() {
                rowDelta+=event.delta.dx;
              });
            },
            onHorizontalDragEnd: (event){
              setState(() {
                selectedRow=-1;
                rowDelta=0;
              });
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.grey
              ),
              child: Builder(builder: (context){
                List<Column> columns=[];
                for(int i=0;i<width;i++){
                  List<Widget> children=[];
                  for(int j=0;j<height;j++){
                    double dx=0;
                    double dy=0;
                    if(selectedColumn==i)dy=columnDelta;
                    if(selectedRow==j)dx=rowDelta;
                    children.add(
                      Transform.translate(
                        offset: Offset(dx,dy),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              color: Colors.black,
                              child: Center(
                                child: Text("${mat[i][j]}",
                                  style: TextStyle(color: Colors.white),
                                )
                              ),
                            ),
                          ),
                        ),
                      )
                    );
                  }
                  columns.add(Column(
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  ));
                }
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: columns,
                );
              }),
            ),
          ),
        )
      ),
    );
  }

}