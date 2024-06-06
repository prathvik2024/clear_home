import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  Widget? imageWidget;
  void Function()? onclick;
  double? width, height;

  CircularImage({super.key, required this.imageWidget,this.width, this.height, this.onclick});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ??  50,
        height: height ?? 50,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width ?? 50 / 2),
            boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.12), spreadRadius: 2)]),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(width ?? 50 / 2),
            child: (onclick != null) ? InkWell(
              onTap: onclick,
              child: imageWidget,
            ) : imageWidget));
  }
}
