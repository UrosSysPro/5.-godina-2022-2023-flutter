import 'package:flutter/cupertino.dart';

class Dot extends StatefulWidget {
  void Function() onTap;
  Dot({required this.onTap});

  @override
  _DotState createState() => _DotState();
}

class _DotState extends State<Dot> {
  Color color = CupertinoColors.systemGrey3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: MouseRegion(
          onEnter: (event) {
            setState(() {
              color = Color.fromARGB(255, 52, 52, 52);
            });
          },
          onExit: (event) {
            setState(() {
              color = Color.fromARGB(255, 200, 200, 200);
            });
          },
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ),
    );
  }
}
