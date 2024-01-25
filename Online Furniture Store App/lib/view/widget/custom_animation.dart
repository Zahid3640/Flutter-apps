import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget customAnimation({required String animation ,required double height,required double width}) {
  return Lottie.asset(animation,height:height,width: width,fit: BoxFit.fill );
}