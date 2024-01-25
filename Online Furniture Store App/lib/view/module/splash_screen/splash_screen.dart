import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:pos/constant/app_color/app_color.dart';
import 'package:pos/view/widget/custom_image.dart';
import 'package:pos/view/widget/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/assets_path/animation_path.dart';
import '../../../constant/assets_path/images_path.dart';
import '../admin/admin_home_screen.dart';
import '../authentication/login_screen.dart';
import '../user/customer_homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5),(){
      navigateMethod();
    });
  }
  Future<void> navigateMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.getBool("authenticate");
     if(prefs.getBool("authenticate") ?? false){
       Get.offAll(() => const UserHomeScreen());
     } else if(prefs.getBool("admin")  ?? false) {
       Get.offAll(() => const AdminHomeScreen());
     }
     else{
       Get.offAll(()  => const SignInScreen());
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.smokeWhiteColor,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(AppAnimationPath.welcome,
                        width: 200, height: 200, fit: BoxFit.contain),
                    Row(
                      children: [
                        Expanded(
                          child:
                    customText(
                    text: "Online Furniture App",
                        color: AppColors.maroonColor,
                        size: 16,
                        fontWeight: FontWeight.bold)
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                customImage(
                    image: AppImagesPath.universityLogo,
                    width: 50,
                    height: 50),
                Expanded(
                    child: customText(
                        text: "COMSATS University Islamabad \n(Vehari Campus)",
                        color: AppColors.maroonColor,
                        size: 16,
                        fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      ),
    );
  }
}
