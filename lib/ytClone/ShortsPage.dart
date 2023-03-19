import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShortsPage extends StatelessWidget {
  const ShortsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colors=[
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.purple
    ];
    return PageView.builder(
      itemCount: colors.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context,index){
        return Stack(
          children: [
            Container(
              color: colors[index],
            ),
            
          ],
        );
      }
    );
  }
}