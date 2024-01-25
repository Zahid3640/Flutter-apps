import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/view/module/admin/pos/upload_product_screen.dart';

import '../../../../constant/app_color/app_color.dart';
import '../../../../controller/data_controller.dart';
import '../../../../firebase/cloud_firestore.dart';
import '../../../widget/custom_icon.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_loader.dart';
import '../../../widget/custom_text.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late DataController _dataController;
   String categoryKey='';
  @override
  void initState() {
    try {
      _dataController = Get.find();
    } catch (exception) {
      _dataController = Get.put(DataController());
    }
    readProduct();
    super.initState();
  }
  Future readProduct() async {
    Future.delayed(const Duration(seconds: 5),() async {
      await _dataController.readProductCategoryData();
      await  _dataController.readProductData(_dataController.key);
    });
  }
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: customText(
                text: "Products",
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
          GetBuilder<DataController>(builder: (_) {
            return  SingleChildScrollView(

              child: Column(
                    children: [
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
                            if(snapshot.hasData){
                              if(categoryKey.isEmpty || categoryKey == "" ){
                                // setState((){
                                //   categoryKey = snapshot.data!.docs.first.id;
                                //   _dataController.saveLocalProductKey(categoryKey);
                                //   _dataController.readProductData(categoryKey);
                                // });
                              }
                            }
                            return SizedBox(
                              height: 50,
                              child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                    return InkWell(
                                      overlayColor:MaterialStateProperty.all(AppColors.transparentColor) ,
                                      onTap: () {
                                        setState(()  {
                                          categoryKey = document.id;
                                           _dataController.saveLocalProductKey(document.id);
                                        _dataController.readProductData(document.id);
                                        });
                                      },
                                      child: FittedBox(
                                        child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: SizedBox(
                                                height: 50,
                                                width: 130,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  color:categoryKey != document.id ? AppColors.pakistanGreenColor:AppColors.orangeColor,
                                                  elevation: 5,
                                                  borderOnForeground: true,
                                                  shadowColor: AppColors.primaryWhiteColor,
                                                  child: Center(
                                                    child: customText(
                                                        text: data['productCategory'],
                                                        color: AppColors.primaryWhiteColor,
                                                        size: 15,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ))),
                                      ),
                                    );
                                  }).toList()),
                            );
                          }
                      ):customLoader(),
                      StreamBuilder<QuerySnapshot>(
                          stream:_dataController.productStream ,
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
                            else if (!snapshot.hasData) {
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
                                                text: "No Product Available",
                                                color: AppColors.primaryWhiteColor,
                                                size: 15,
                                                fontWeight: FontWeight.bold),
                                          ))));
                            }
                            else {
                              return  ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                    String imageUrl = data["image"] ;
                                    imageUrl = imageUrl.replaceAll( RegExp(r'(\?alt).*'), '');
                                    imageUrl = imageUrl.replaceAll( RegExp(r'https://firebasestorage.googleapis.com/v0/b/mobile-app-for-pos.appspot.com/o/'), '');
                                    imageUrl = imageUrl.replaceAll( RegExp(r'(%2F)'), '/');
                                    return  Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: SizedBox(
                                          height: 100,
                                          width: 130,
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              color: AppColors.maroonColor.withOpacity(0.5),
                                              elevation: 5,
                                              borderOnForeground: true,
                                              shadowColor: AppColors.primaryWhiteColor,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: customNetworkImage(image: data["image"],height:100 ,width: 100)),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 10),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            customText(text: data["product"], color: AppColors.primaryWhiteColor, size: 15, fontWeight: FontWeight.bold),
                                                            customText(text: "Price = ${data["price"]} \$", color: AppColors.primaryWhiteColor, size: 15, fontWeight: FontWeight.bold),
                                                            customText(text: "Quantity = ${data["quantity"]}", color: AppColors.primaryWhiteColor, size: 15, fontWeight: FontWeight.bold),
                                                          ],
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          InkWell(
                                                              overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                                                              onTap: () async {
                                                                await CloudFirestoreServices().deleteProduct(productCatKey:categoryKey ,productKey: document.id );
                                                                await FirebaseStorage.instance.ref().child(imageUrl).delete();
                                                              },
                                                              child: customIcon(icon: Icons.delete, size: 30, color: AppColors.primaryWhiteColor)),
                                                          InkWell(
                                                              overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                                                              onTap: () {
                                                                Get.to(() => ProductUploadScreen(categoryKey: categoryKey,productKey: document.id,imageUrl: imageUrl,));
                                                              },
                                                              child: customIcon(icon: Icons.edit, size: 30, color: AppColors.primaryWhiteColor)),
                                                        ],
                                                      ))
                                                ],
                                              )
                                          )),
                                    );
                                  }).toList());
                            }
                          }
                      )],
                  ),
            );
          }),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                  if(categoryKey.isNotEmpty) {
                    Get.to(() => ProductUploadScreen(categoryKey: categoryKey,productKey: "",imageUrl: '',));
                  }
                  else{
                    _dataController.showException(status: "Exception",message: "Product Category not Selected");
                  }
              },
              elevation: 10,
              splashColor: AppColors.primaryWhiteColor.withOpacity(0.5),
              shape: const CircleBorder(),
              backgroundColor: AppColors.orangeColor,
              child: customIcon(icon: Icons.add, size: 30, color: AppColors.primaryWhiteColor),
            )
        );
  }
}
