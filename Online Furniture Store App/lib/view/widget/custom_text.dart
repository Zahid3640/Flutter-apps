import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customText({required String text,required Color color,required double size,required FontWeight fontWeight}) {
  return Text(text,style: TextStyle(color: color,fontSize: size.sp,fontWeight:fontWeight ),textAlign: TextAlign.center,);
}