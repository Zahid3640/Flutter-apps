import 'package:flutter/cupertino.dart';

Widget customIcon({required IconData icon, required double size, required Color color}) {
  return Icon(
    icon,
    size: size,
    color: color,
  );
}

Widget customAssetsIcon({required String icon, required double height, required double width}) {
  return Image.asset(
    icon,
    fit: BoxFit.contain,
    height: height,
    width: width,
  );
}