import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/constant/assets_path/images_path.dart';
import 'package:pos/view/module/admin/pos/product_screen.dart';
import 'package:pos/view/module/admin/pos/produt_category_screen.dart';
import 'package:pos/view/widget/custom_image.dart';

import '../../../../constant/app_color/app_color.dart';
import '../../../../constant/assets_path/animation_path.dart';
import '../../../../controller/data_controller.dart';
import '../../../widget/custom_animation.dart';
import '../../../widget/custom_text.dart';



class AdminPOSScreen extends StatefulWidget {
  const AdminPOSScreen({Key? key}) : super(key: key);

  @override
  State<AdminPOSScreen> createState() => _AdminPOSScreenState();
}

class _AdminPOSScreenState extends State<AdminPOSScreen> {
  late DataController _dataController;
  void initState() {
    try {
      _dataController = Get.find();
    } catch (exception) {
      _dataController = Get.put(DataController());
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText(text: "POS", color: AppColors.primaryWhiteColor, size: 20, fontWeight: FontWeight.bold),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [AppColors.orangeColor, AppColors.blackBeanColor])),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customAnimation(animation: AppAnimationPath.management, height: 150, width: double.infinity),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 150,
                decoration: BoxDecoration(
                  color: AppColors.orangeColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(text: "${_dataController.totalOrdersPrice} \$", color: AppColors.primaryWhiteColor, size: 15, fontWeight: FontWeight.bold),
                      const SizedBox(height: 10,),
                      customText(text: "Sale(s) Total", color: AppColors.primaryWhiteColor, size: 15, fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                width: 150,
                decoration: BoxDecoration(
                    color: AppColors.pakistanGreenColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(text: _dataController.totalOrders.toString(), color: AppColors.primaryWhiteColor, size: 15, fontWeight: FontWeight.bold),
                      const SizedBox(height: 10,),
                      customText(text: "Sale(s) Count", color: AppColors.primaryWhiteColor, size: 15, fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Column(
                    children: [
                      InkWell(
                          overlayColor:MaterialStateProperty .all(AppColors.transparentColor),
                          onTap: () {
                             Get.to(() => const ProductScreen());
                          },
                          child: customImage(image: AppImagesPath.product, width: 100, height: 80)),
                      customText(text: "Product", color: AppColors.pakistanGreenColor, size: 15, fontWeight: FontWeight.bold)
                    ],
                  ),

                Column(
                    children: [
                      InkWell(
                        overlayColor:MaterialStateProperty .all(AppColors.transparentColor),
                          onTap: () {
                            Get.to(() => const ProductCategoryScreen());
                          },
                          child: customImage(image: AppImagesPath.productCategory, width: 100, height: 80)),
                      customText(text: "Product Category", color: AppColors.orangeColor, size: 15, fontWeight: FontWeight.bold)
                    ],
                  ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
