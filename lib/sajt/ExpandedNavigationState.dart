import 'package:flutter/cupertino.dart';

class ExpandedNavigationState extends ChangeNotifier{
  bool expanded=false;

  void setExpanded(bool expanded){
    this.expanded=expanded;
    notifyListeners();
  }
}