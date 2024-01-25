import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/view/module/authentication/signup_screen.dart';
import 'package:pos/view/module/user/customer_homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/app_color/app_color.dart';
import '../../../constant/assets_path/animation_path.dart';
import '../../../controller/authentication_helper.dart';
import '../../../firebase/cloud_firestore.dart';
import '../../widget/custom_animation.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_textFormField.dart';
import '../admin/admin_home_screen.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryWhiteColor,
        appBar: AppBar(
          title: customText(
              text: "Welcome",
              color: AppColors.primaryWhiteColor,
              size: 20,
              fontWeight: FontWeight.bold),
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
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customAnimation(animation: AppAnimationPath.login, height: 200, width: 200),
               Column(
                 children: [
                   SizedBox(
                     width: Get.size.width * 0.8,
                     child:  customTextFormField(textEditingController: emailController,hintText: "Enter Your Email",obscureText: false,email: true,onchange: () async {
                       FocusManager.instance.primaryFocus?.unfocus();
                     }),
                   ),
                   SizedBox(
                     width: Get.size.width * 0.8,
                     child:  customTextFormField(textEditingController: passwordController,hintText: "Enter Your Password",obscureText: true,email: false,onchange: () async {
                       FocusManager.instance.primaryFocus?.unfocus();
                     }),
                   ),
                   InkWell(
                     overlayColor:MaterialStateProperty.all(AppColors.transparentColor) ,
                     onTap: () async {
                       {
                         if(await AuthenticationHelper().signIn(email: emailController.text.trim(),
                             password: passwordController.text.trim())) {
                           emailController.clear();
                           passwordController.clear();
                           SharedPreferences prefs = await SharedPreferences.getInstance();
                           await prefs.setBool("authenticate", true);
                           Get.off(() =>const UserHomeScreen());
                         }
                       }
                       FocusManager.instance.primaryFocus?.unfocus();

                     },
                     child: Container(
                       height: 40,
                       width: 150,
                       margin: const EdgeInsets.symmetric(vertical: 10),
                       decoration: BoxDecoration(
                         color: AppColors.pakistanGreenColor,
                         borderRadius: BorderRadius.circular(30),
                       ),
                       child:  Center(
                         child:  customText(
                             text: "Sign In",
                             color: AppColors.primaryWhiteColor,
                             size: 15,
                             fontWeight: FontWeight.bold),
                       ),

                     ),
                   ),
                   customText(
                       text: "or",
                       color: AppColors.blackColor,
                       size: 15,
                       fontWeight: FontWeight.bold),
                   InkWell(
                     overlayColor:MaterialStateProperty.all(AppColors.transparentColor) ,
                     onTap: (){
                       Get.to(() =>const SignUpScreen());
                     },
                     child: Container(
                       height: 40,
                       width: 150,
                       margin: const EdgeInsets.symmetric(vertical: 10),
                       decoration: BoxDecoration(
                         color: AppColors.blackColor,
                         borderRadius: BorderRadius.circular(30),
                       ),
                       child: Center(
                         child:  customText(
                             text: "Sign Up",
                             color: AppColors.primaryWhiteColor,
                             size: 15,
                             fontWeight: FontWeight.bold),
                       ),
                     ),
                   ),
                   InkWell(
                     overlayColor:MaterialStateProperty.all(AppColors.transparentColor) ,
                     onTap: () async {
                       if( await
                       CloudFirestoreServices().getAdmin(
                           email: emailController.text.trim(),
                           password: passwordController.text.trim()
                       ))
                       {
                         SharedPreferences prefs = await SharedPreferences.getInstance();
                         await prefs.setBool("admin", true);
                         Get.off(() => const AdminHomeScreen());
                       }
                       else {
                         Get.snackbar("Failed ", "Admin email or password is incorrect" ,duration: const Duration(seconds: 2));
                       }
                       FocusManager.instance.primaryFocus?.unfocus();
                       emailController.clear();
                       passwordController.clear();
                     },
                     child: Container(
                       height: 40,
                       width: 250,
                       margin: const EdgeInsets.only(top: 50),
                       decoration: BoxDecoration(
                         color: AppColors.orangeColor,
                         borderRadius: BorderRadius.circular(30),
                       ),
                       child: Center(
                         child:  customText(
                             text: "Admin Sign In",
                             color: AppColors.primaryWhiteColor,
                             size: 15,
                             fontWeight: FontWeight.bold),
                       ),
                     ),
                   ),
                 ],
               )
                ],
              ),
            ),
          ),
        )
    );
  }
}