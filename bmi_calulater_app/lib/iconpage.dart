import 'package:flutter/material.dart';
import 'constant.dart';
class Repeattexticonswidgets extends StatelessWidget {
  Repeattexticonswidgets({required this.iconData,required this.label});
  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 85.0,
          color: Colors.white,
        ),
        SizedBox(height: 15,),
        Text(label,style: klabelstyle,)
      ],
    );
  }
}