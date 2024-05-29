import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  Widget? imageWidget;
  void Function()? onclick;
  CircularImage({super.key, required this.imageWidget, this.onclick});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 50,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.12), spreadRadius: 2)]),
        child: ClipRRect(
            child: (onclick != null) ? InkWell(
              onTap: onclick,
              child: imageWidget,
            ) : imageWidget,
            borderRadius: BorderRadius.circular(25)));
  }
}
