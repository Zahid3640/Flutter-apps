import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/view/module/user/customer_homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/app_color/app_color.dart';
import '../../../constant/assets_path/animation_path.dart';
import '../../../controller/authentication_helper.dart';
import '../../../firebase/cloud_firestore.dart';
import '../../../utils/easy_loading.dart';
import '../../widget/custom_animation.dart';
import '../../widget/custom_loader.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_textFormField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhiteColor,
      appBar: AppBar(
        title: customText(
            text: "Sign Up",
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customAnimation(
                    animation: AppAnimationPath.login,
                    height: 200,
                    width:200),
                Column(
                  children: [
                SizedBox(
                  width: Get.size.width * 0.8,
                  child: customTextFormField(
                      textEditingController: nameController,
                      hintText: "Enter Your Name",
                      obscureText: false,
                      email: false,
                      onchange: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }),
                ),
                SizedBox(
                  width: Get.size.width * 0.8,
                  child: customTextFormField(
                      textEditingController: emailController,
                      hintText: "Enter Your Email",
                      obscureText: false,
                      email: true,
                      onchange: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }),
                ),
                SizedBox(
                  width: Get.size.width * 0.8,
                  child: customTextFormField(
                      textEditingController: passwordController,
                      hintText: "Enter Your Password",
                      obscureText: true,
                      email: false,
                      onchange: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }),
                ),
                Center(
                  child: InkWell(
                    overlayColor: MaterialStateProperty.all(
                        AppColors.transparentColor),
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        showLoading();
                        await AuthenticationHelper().signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim());
                        hideLoading();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool("authenticate", true);
                        if (AuthenticationHelper().user != null) {
                          await CloudFirestoreServices().addUser(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim());
                          Get.offAll(() => const UserHomeScreen());
                          emailController.clear();
                          passwordController.clear();
                          nameController.clear();
                        }
                      }
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.orangeColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: customText(
                            text: "Sign Up",
                            size: 15,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
