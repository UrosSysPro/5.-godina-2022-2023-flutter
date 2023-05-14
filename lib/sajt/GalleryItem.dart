import 'package:app/sajt/Gallery.dart';
import 'package:flutter/material.dart';

class GalleryItem{
  Color color;
  String descrtiption,photoUrl;
  GalleryItem({
    this.color=Colors.black,
    required this.descrtiption,
    this.photoUrl="",
  });
}