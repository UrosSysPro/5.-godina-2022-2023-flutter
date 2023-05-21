import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/sajt/NavBarItem.dart';

import 'package:app/sajt/PageSection.dart';

import 'package:app/sajt/Footer.dart';
import 'package:app/sajt/Gallery.dart';
import 'package:app/sajt/GalleryItem.dart';
import 'package:provider/provider.dart';

import 'ExpandedNavigationState.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExpandedNavigationState>(
      create: (context) {
        return ExpandedNavigationState();
      },
      child: Builder(builder: (context) {
        return CupertinoApp(
          home: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor:
                  !context.watch<ExpandedNavigationState>().expanded
                      ? Colors.black.withAlpha(180)
                      : Colors.transparent,
              middle: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NavBarItem(
                    icon: Icons.apple,
                  ),
                  NavBarItem(
                    text: "Store",
                  ),
                  NavBarItem(
                    text: "Mac",
                  ),
                  NavBarItem(
                    text: "iPad",
                  ),
                  NavBarItem(
                    text: "iPhone",
                  ),
                  NavBarItem(
                    text: "AirPods",
                  ),
                  NavBarItem(
                    text: "Watch",
                  ),
                  NavBarItem(text: "TV & Home"),
                  NavBarItem(
                    text: "Entertainment",
                  ),
                  NavBarItem(
                    text: "Accessories",
                  ),
                  NavBarItem(
                    text: "Support",
                  ),
                  NavBarItem(
                    icon: CupertinoIcons.search,
                  ),
                  NavBarItem(
                    icon: CupertinoIcons.bag,
                  ),
                ],
              ),
            ),
            child: Stack(
              children: [
                ListView(
                  children: [
                    SizedBox(
                      height: 44,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Get \$200–\$630 in credit toward iPhone 14 or iPhone 14 Pro when you trade in iPhone 11 or higher.",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    PageSection(
                      title: "iPhone 14 Pro",
                      subtitle: "Pro. Beyond.",
                      buttonText1: "Learn more >",
                      buttonText2: "Buy >",
                    ),
                    PageSection(
                      title: "iPhone 14 Pro",
                      subtitle: "Wonderfull.",
                      buttonText1: "Learn more >",
                      buttonText2: "Buy >",
                      dark: false,
                    ),
                    PageSection(
                      title: "Watch",
                      subtitle: "A healthy leap ahead.",
                      buttonText1: "Learn more >",
                      buttonText2: "Buy >",
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PageSection(
                            title: "Watch",
                            subtitle: "A healthy leap ahead.",
                            buttonText1: "Learn more >",
                            buttonText2: "Buy >",
                            dark: false,
                          ),
                        ),
                        Expanded(
                          child: PageSection(
                            title: "Watch",
                            subtitle: "A healthy leap ahead.",
                            buttonText1: "Learn more >",
                            buttonText2: "Buy >",
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PageSection(
                            title: "Watch",
                            subtitle: "A healthy leap ahead.",
                            buttonText1: "Learn more >",
                            buttonText2: "Buy >",
                            dark: false,
                          ),
                        ),
                        Expanded(
                          child: PageSection(
                            title: "Watch",
                            subtitle: "A healthy leap ahead.",
                            buttonText1: "Learn more >",
                            buttonText2: "Buy >",
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PageSection(
                            title: "Watch",
                            subtitle: "A healthy leap ahead.",
                            buttonText1: "Learn more >",
                            buttonText2: "Buy >",
                            dark: false,
                          ),
                        ),
                        Expanded(
                          child: PageSection(
                            title: "Watch",
                            subtitle: "A healthy leap ahead.",
                            buttonText1: "Learn more >",
                            buttonText2: "Buy >",
                            dark: false,
                          ),
                        )
                      ],
                    ),
                    Gallery(
                      list: [
                        GalleryItem(
                          descrtiption:
                              "lfdjas;l dskf;jadslfk dsfljsdfl skdjflas sdflfslfs dflkfjslf ldksfj",
                          color: Colors.green,
                        ),
                        GalleryItem(
                          descrtiption:
                              "lfdjas;l dskf;jadslfk dsfljsdfl skdjflas sdflfslfs dflkfjslf ldksfj",
                          color: Colors.blue,
                        ),
                        GalleryItem(
                          descrtiption:
                              "lfdjas;l dskf;jadslfk dsfljsdfl skdjflas sdflfslfs dflkfjslf ldksfj",
                          color: Colors.red,
                        ),
                        GalleryItem(
                          descrtiption:
                              "lfdjas;l dskf;jadslfk dsfljsdfl skdjflas sdflfslfs dflkfjslf ldksfj",
                          color: Colors.purple,
                        ),
                        GalleryItem(
                          descrtiption:
                              "lfdjas;l dskf;jadslfk dsfljsdfl skdjflas sdflfslfs dflkfjslf ldksfj",
                          color: Colors.orange,
                        ),
                      ],
                    ),
                    Footer(),
                  ],
                ),
                Builder(
                  builder: (context){
                    var expanded=context.watch<ExpandedNavigationState>().expanded;
                    if(expanded)
                      return Positioned(
                        top: 0,bottom: 0,left: 0,right: 0,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10,sigmaY: 10
                          ),
                          child: Container(),
                        ),
                      );
                    return Container();
                  },
                ),
                Container(
                  height: context.watch<ExpandedNavigationState>().expanded
                      ? 500
                      : 0,
                  width: double.infinity,
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
