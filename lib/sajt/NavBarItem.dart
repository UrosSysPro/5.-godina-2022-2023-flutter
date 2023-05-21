import 'package:app/sajt/ExpandedNavigationState.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class NavBarItem extends StatelessWidget {
  String? text;
  IconData? icon;
  NavBarItem({this.text,this.icon});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event){
        context.read<ExpandedNavigationState>().setExpanded(true);
        // print("enter");
      },
      onExit: (event){
        context.read<ExpandedNavigationState>().setExpanded(false);
        // print("exit");
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: text!=null?Text(
          text!,
          style: TextStyle(
            color: CupertinoColors.systemGrey2,
            fontWeight: FontWeight.normal,
            fontSize: 12.5  
          ),
        ):Icon(
          icon!,
          size: 22,
          color: CupertinoColors.systemGrey2,
        ),
      ),
    );
  }
}