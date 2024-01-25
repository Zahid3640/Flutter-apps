import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget customImage({required String image,required double width,required double height}) {
  return Image.asset(image,width: width,height: height,fit: BoxFit.fill,);
}
Widget customNetworkImage({required String image,required double width,required double height}) {
  return Image.network(image,width: width,height: height,fit: BoxFit.fill,);
}
Widget myNetworkImage(
    {required String imageUrl,
      required double width,
      required double height,
      BoxFit? boxFit,
      required Color progressColor}) {
  try {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: boxFit ?? BoxFit.contain,
      imageBuilder: (context, imageProvider) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit ?? BoxFit.contain,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return SizedBox(
          width: width,
          height: height,
          child: Center(
            child: CircularProgressIndicator(value: downloadProgress.progress, color: progressColor),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return noImageFound(width: width, height: height);
      },
    );
  } catch (exception) {
    return noImageFound(width: width, height: height);
  }
}
Widget noImageFound({required double width, required double height}) {
  return SizedBox(
    width: width,
    height: height,
    child: const Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text("No image!"),
      ),
    ),
  );
}