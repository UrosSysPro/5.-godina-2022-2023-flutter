import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardEditPage extends StatefulWidget {

  List<String> lista;
  int index;
  
  CardEditPage(this.lista,this.index);

  @override
  _CardEditPageState createState() => _CardEditPageState();
}

class _CardEditPageState extends State<CardEditPage> {
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
        title: Text("Edit post"),
      ),
      body: Center(
        child: TextFormField(
          initialValue: widget.lista[widget.index],
          decoration: InputDecoration(
            labelText: "Post",
            border: OutlineInputBorder()
          ),
          onChanged: (value){
            widget.lista[widget.index]=value;
          },

        ),
      ),
    );
  }
}