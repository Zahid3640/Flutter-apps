import 'package:flutter/material.dart';
import 'constant.dart';
class RepeatContainerCode extends StatelessWidget {
  const RepeatContainerCode({ required this.colorr,required this.cardwidgets});
  final Color colorr;
  final Widget cardwidgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: cardwidgets,
      decoration: BoxDecoration(
          color: colorr,
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}