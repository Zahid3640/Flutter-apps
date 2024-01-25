import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/view/widget/custom_loader.dart';

import '../../../../constant/app_color/app_color.dart';
import '../../../../controller/data_controller.dart';
import '../../../../firebase/cloud_firestore.dart';
import '../../../widget/custom_icon.dart';
import '../../../widget/custom_text.dart';
class ProductCategoryScreen extends StatefulWidget {
  const ProductCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController =TextEditingController();
  late DataController _dataController;
  @override
  void initState() {
    try {
      _dataController = Get.find();
    } catch (exception) {
      _dataController = Get.put(DataController());
    }
    _dataController.readProductCategoryData();
    super.initState();
  }
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
          appBar: AppBar(
            title: customText(
                text: "Product Categories",
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
          body:
          GetBuilder<DataController>(builder: (_){
            return
            GestureDetector(
            onTap: () {
              if (WidgetsBinding.instance.window.viewInsets.bottom != 0.0) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: Form(
              key: _formKey,
              child:
              _dataController.isProductCategory ?
              StreamBuilder<QuerySnapshot>(
                  stream:_dataController.productCategoryStream ,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                          child: SizedBox(
                              height: 70,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: AppColors.pakistanGreenColor,
                                  elevation: 5,
                                  borderOnForeground: true,
                                  shadowColor: AppColors.primaryWhiteColor,
                                  child: Center(
                                    child: customText(
                                        text: "No Product Category Available",
                                        color: AppColors.primaryWhiteColor,
                                        size: 15,
                                        fontWeight: FontWeight.bold),
                                  ))));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return customLoader();
                    }
                    return ListView(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                              child: SizedBox(
                                  height: 70,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: AppColors.pakistanGreenColor,
                                    elevation: 5,
                                    borderOnForeground: true,
                                    shadowColor: AppColors.primaryWhiteColor,
                                    child: Row(
                                      crossAxisAlignment:CrossAxisAlignment.center ,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: customText(
                                                text: data['productCategory'],
                                                color: AppColors.primaryWhiteColor,
                                                size: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                    overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                                                    onTap: () async {
                                                      await CloudFirestoreServices().deleteProductCategory(key: document.id );
                                                    },
                                                    child: customIcon(icon: Icons.delete, size: 30, color: AppColors.primaryWhiteColor)),
                                                InkWell(
                                                    overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                                                    onTap: () {
                                                      textEditingController.text =data['productCategory'];
                                                      _dataController.textSingleInputDialog(textEditingController: textEditingController,title: "Update Category",hint: data['productCategory'],method: () async {
                                                        if(_formKey.currentState!.validate()){
                                                          await CloudFirestoreServices().updateProductCategory(key: document.id,input:textEditingController.text.trim() );
                                                          Get.back();
                                                          textEditingController.clear();
                                                        }
                                                      });
                                                    },
                                                    child: customIcon(icon: Icons.edit, size: 30, color: AppColors.primaryWhiteColor)),
                                              ],
                                            ))
                                      ],
                                    ),
                                  )));
                        }).toList());
                  }
              ):customLoader(),
            ),
          );}),

          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              _dataController.textSingleInputDialog(textEditingController: textEditingController,title: "Add Category",hint: "Enter Product Category",method: () async {
                if(_formKey.currentState!.validate()){
                  await CloudFirestoreServices().addProductCategory(input: textEditingController.text.trim());
                  Get.back();
                  textEditingController.clear();
                }
              });
            },
            elevation: 10,
            splashColor: AppColors.primaryWhiteColor.withOpacity(0.5),
            shape: const CircleBorder(),
            backgroundColor: AppColors.orangeColor,
            child: customIcon(icon: Icons.add, size: 30, color: AppColors.primaryWhiteColor),
          ),
        );

  }
}
