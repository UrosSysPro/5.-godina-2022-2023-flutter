import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("App"),
              backgroundColor: Color(0xff0f0f0f),
              actions: [
                createIcon(Icon(Icons.cast)),
                createIcon(Icon(Icons.notifications_active)),
                createIcon(Icon(Icons.search)),
                createIcon(Icon(Icons.person)),
              ],
              floating: true,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: SizedBox(
                  height: 30,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      FilterChip(
                          label: Text("gaming"), onSelected: (selected) {}),
                      FilterChip(
                          label: Text("gaming"), onSelected: (selected) {}),
                      FilterChip(
                          label: Text("gaming"), onSelected: (selected) {}),
                      FilterChip(
                          label: Text("gaming"), onSelected: (selected) {}),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate(childCount: 10, (context, index) {
                return Container(
                  height: 300,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.black26,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            FlutterLogo(
                              size: 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Video name"),
                                Text("Video description")
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
        DraggableScrollableSheet(
            snap: true,
            initialChildSize: 0.15,
            snapSizes: [0.15, 1.0],
            minChildSize: 0.15,
            maxChildSize: 1.0,
            builder: (context, controller) {
              return ListView.builder(
                controller: controller,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Container(
                    child: Center(child: Text("hello")),
                    color: Colors.lime,
                    height: 300,
                  );
                },
              );
            }),
      ],
    );
  }

  Widget createIcon(Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: IconButton(
        onPressed: () {},
        icon: icon,
      ),
    );
  }
}
