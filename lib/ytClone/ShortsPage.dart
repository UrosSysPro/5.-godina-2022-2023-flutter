import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShortsPage extends StatefulWidget {
  const ShortsPage({ Key? key }) : super(key: key);

  @override
  State<ShortsPage> createState() => _ShortsPageState();
}

class _ShortsPageState extends State<ShortsPage> {

  late PageController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=PageController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colors=[
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.purple
    ];
    return PageView.builder(
      controller: controller,
      itemCount: colors.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context,index){
        return Stack(
          children: [
            Container(
              color: colors[index],
            ),
            Column(
              children: [
                SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.search)
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.photo)
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.more_vert)
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            FlutterLogo(),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Ime kanala"),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red
                                  ),
                                  child: Text("Subscribe"),
                                  onPressed: (){},
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.thumb_up),
                          ),
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.thumb_down)
                          ),
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.comment)
                          ),
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.share)
                          ),
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.shuffle)
                          ),
                        ],
                      )
                    ],
                  ) 
                ),
              ],
            )
          ],
        );
      }
    );
  }
}