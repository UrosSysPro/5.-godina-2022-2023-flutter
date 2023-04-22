import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int width = 4;
  int height = 4;
  double cellSize = 100;
  List<List<int>> mat = [];
  int selectedRow=-1;
  int selectedColumn=-1;
  double rowOffset=0;
  double columnOffset=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < width; i++) {
      mat.add([]);
      for (int j = 0; j < height; j++) {
        mat[i].add(i + width * j);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Puzzle",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: eventListener(
            grid()
          ),
        ),
      ),
    );
  }

  Widget grid() {
    List<Widget> columns = [];
    for (int i = 0; i < width; i++) {
      List<Widget> children = [];
      for (int j = 0; j < height; j++) {
        double dx=0,dy=0;
        if(selectedRow==j)dx=rowOffset;
        if(selectedColumn==i)dy=columnOffset;
        children.add(Transform.translate(
          offset: Offset(dx,dy),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: cellSize - 4,
              height: cellSize - 4,
              color: Colors.black,
              child: Center(
                child: Text(
                  "${mat[i][j]}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ));
      }
      columns.add(Column(
        children: children,
        mainAxisSize: MainAxisSize.min,
      ));
    }
    return Row(
      children: columns,
      mainAxisSize: MainAxisSize.min,
    );
  }
  
  Widget eventListener(Widget child){
    return GestureDetector(
      onHorizontalDragStart: (event){
        selectedRow=event.localPosition.dy~/cellSize;
      },
      onHorizontalDragUpdate: (event){setState(() {
        rowOffset+=event.delta.dx;
      });},
      onHorizontalDragEnd: (event){setState(() {
        selectedRow=-1;
        rowOffset=0;
      });},
      onVerticalDragStart:  (event){
        selectedColumn=event.localPosition.dx~/cellSize;
      },
      onVerticalDragUpdate: (event){setState(() {
        columnOffset+=event.delta.dy;
      });},
      onVerticalDragEnd: (event){setState(() {
        selectedColumn=-1;
        columnOffset=0;
      });},
      child: child,
    );
  }
}
