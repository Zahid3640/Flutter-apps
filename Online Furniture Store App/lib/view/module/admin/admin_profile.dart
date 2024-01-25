import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/constant/assets_path/animation_path.dart';
import 'package:pos/view/widget/custom_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/app_color/app_color.dart';
import '../../../controller/data_controller.dart';
import '../../widget/custom_text.dart';
import '../authentication/login_screen.dart';


class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({Key? key}) : super(key: key);

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
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
        title: customText(text: "Profile", color: AppColors.primaryWhiteColor, size: 20, fontWeight: FontWeight.bold),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [AppColors.orangeColor, AppColors.blackBeanColor])),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
                overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('admin');
                  Get.offAll(()  => const SignInScreen());
                },
                child: customAnimation(animation: AppAnimationPath.logout, height: 20, width: 50)),
          )
        ],
      ),
      body: GetBuilder<DataController>(builder: (_) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: customAnimation(animation: AppAnimationPath.profile, height: double.infinity, width: double.infinity)),

            Expanded(
              child: Column(
                children: [
                  customText(text: "Name - - -  ${_dataController.adminName}", color: AppColors.maroonColor, size: 15, fontWeight: FontWeight.bold),
                  SizedBox(height: 10,),
                  customText(text: "Email - - -  ${_dataController.adminMail}", color: AppColors.maroonColor, size: 15, fontWeight: FontWeight.bold),
                  SizedBox(height: 10,),
                  customText(text: "Admin Id - - -  ${_dataController.adminId}", color: AppColors.maroonColor, size: 15, fontWeight: FontWeight.bold),
                ],
              ),
            ),
          ],),
        );
      }) ,
    );
  }
}
