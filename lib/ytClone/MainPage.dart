import 'package:app/ytClone/HomePage.dart';
import 'package:app/ytClone/ShortsPage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Title",
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Builder(builder: (context) {
          if (currentPage == 0) return HomePage();
          if (currentPage == 1) return ShortsPage();
          return Container();
        }),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          iconSize: 25,
          selectedFontSize: 13,
          unselectedFontSize: 13,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_call_outlined),
              label: "Shorts",
              activeIcon: Icon(Icons.video_call),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.folder), label: "Subscriptions"),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_add), label: "Library"),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: (){},
        //   child: Icon(Icons.add),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      ),
    );
  }
}

// ui=build(state)