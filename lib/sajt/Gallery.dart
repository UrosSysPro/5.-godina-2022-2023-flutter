import 'package:app/sajt/GalleryItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  List<GalleryItem> list;
  Gallery({
    required this.list,
  });

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late PageController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=PageController(
      viewportFraction: 0.9
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 660,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: widget.list.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: [
                      Container(
                        color: widget.list[index].color,
                      ),
                      Positioned(
                        bottom: 50,
                        left: 50,
                        child: Row(
                          children: [
                            FilledButton(
                              child:Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 22,vertical: 12),
                                child: Text(
                                  "Stream Now",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                  ),  
                                ),
                              ),
                              onPressed:(){},
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text("Lorem ",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(widget.list[index].descrtiption)
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: Builder(
              builder: (context){
                double size=10;
                List<Widget> children=[];
                for(int i=0;i<widget.list.length;i++){
                  var item=widget.list[i];
                  children.add(
                    GestureDetector(
                      onTap: (){
                        controller.animateToPage(i, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: size,height: size,
                          decoration: BoxDecoration(
                            color: CupertinoColors.darkBackgroundGray,
                            borderRadius: BorderRadius.circular(size/2.0)
                          ),
                        ),
                      ),
                    )
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}