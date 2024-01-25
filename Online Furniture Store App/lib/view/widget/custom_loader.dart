import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constant/app_color/app_color.dart';

Widget customLoader() {
  return const SpinKitDualRing(
    size: 50.0,
    color: AppColors.orangeColor,
    lineWidth: 5,
  );
}