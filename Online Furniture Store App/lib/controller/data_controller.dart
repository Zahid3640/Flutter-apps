import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/app_color/app_color.dart';
import '../firebase/cloud_firestore.dart';
import '../model/customer_shopping_model.dart';
import '../view/widget/custom_text.dart';
import '../view/widget/custom_textFormField.dart';

class DataController extends GetxController {

  @override
  void onInit() {
    readData();
    super.onInit();
  }
  void readData() async{
   await getLocalProductKey();
   await readAllOrders();
   await  readOrderCount();
   await  readAdminInfo();
   await  readProductCategoryData();
   update();
  }
   Stream<QuerySnapshot>? productCategoryStream;
   Stream<QuerySnapshot>? productStream;
   Stream<QuerySnapshot>? currentUserOrders;
   Stream<QuerySnapshot>? allOrders;
   Stream<DocumentSnapshot>? orderCount;
   Stream<DocumentSnapshot>? adminInfo;
   Stream<DocumentSnapshot>? userInfo;
   List<Products> shoppingProductList = [];
   XFile? imageFile ;
  bool isImageSelected= false;
  bool isProductCategory = false;
  bool isImageUploaded = false;
   int totalProduct=0 ;
   double totalPrice =0;
   int totalOrders =0;
   double totalOrdersPrice =0;
   String adminName="";
   String adminMail="";
   String adminId="";
  String userName="";
  String userMail="";
  String userId="";
  String key ='';
  static  final FirebaseStorage _storageService = FirebaseStorage.instance;
  String imageUrl = " ";
  UploadTask? uploadTask;
  final ImagePicker _picker = ImagePicker();
  Future readProductCategoryData() async{
    productCategoryStream = await CloudFirestoreServices().readProductCategory();
    isProductCategory = true;
    update();
  }

  Future readProductData(String key) async {
    productStream = await CloudFirestoreServices().readProduct(key);
    isProductCategory = true;
    update();
  }

  Future readCurrentUserOrders(String uid) async {
    currentUserOrders = await CloudFirestoreServices().readCurrentUserOrder(uid);
    update();
  }

  Future readAllOrders() async {
    allOrders = await CloudFirestoreServices().readAllOrder();
    update();
  }

  Future readOrderCount() async {
    orderCount= await  CloudFirestoreServices().readOrderCount();
    orderCount!.forEach((element) {
      totalOrdersPrice = double.parse(element["total_price"]);
      totalOrders = int.parse(element["total_orders"]);
    });
    update();
  }

  Future readAdminInfo() async {
    adminInfo= await  CloudFirestoreServices().readAdminInfo();
    adminInfo!.forEach((element) {
      adminName = element["name"];
      adminMail = element["mail"];
      adminId = element.id;
    });
    update();
  }
  Future readUserInfo() async {
    userInfo= await  CloudFirestoreServices().readUserInfo();
    userInfo!.forEach((element) {
      userName = element["name"];
      userMail = element["email"];
      userId = element.id;
    });
    update();
  }


  void pickImageFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = pickedFile;
      isImageSelected = true;
    }
    else {
      isImageSelected = false;
    }
    update();
  }
  Future uploadProductImage({required XFile? image}) async {
    final firebaseStorageRef = _storageService.ref().child('uploads/${image!.name}');
    uploadTask = firebaseStorageRef.putFile(File(image.path));
    final snapshot = await uploadTask!.whenComplete(() {});
    final imageDownloadUrl  = await snapshot.ref.getDownloadURL();
    if(imageDownloadUrl.isNotEmpty){
      imageUrl = imageDownloadUrl;
      isImageUploaded = true;
    }
    else{
      isImageUploaded = false;
    }

    update();
  }

void clearSelectedImage() {
  isImageSelected = false;
  isImageUploaded = false;
}
  void textSingleInputDialog (
      {required TextEditingController textEditingController,required String title,required String hint, required VoidCallback method}){
     Get.defaultDialog(
      backgroundColor: AppColors.primaryWhiteColor,
      title: title,
      titleStyle:  const TextStyle(color: AppColors.blackColor, fontSize: 20,  fontWeight: FontWeight.bold),
      content: Column(
        children: [
          customTextFormField(textEditingController: textEditingController,hintText: hint,email: false,obscureText: false,onchange: () async {
            FocusManager.instance.primaryFocus?.unfocus();
          }),
          const SizedBox(height: 30,),
          InkWell(
            overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
            onTap: () async {
             method();
            },
            child: Container(
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                  color: AppColors.orangeColor,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: customText(text: "Submit", color: AppColors.blackColor, size: 15, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  void addShoppingProduct({required String name,required double price,required int quantity,required String image,required String cat,required String pra,required String stock}) async {
    shoppingProductList.add(Products(productName:name, price: price, quantity: quantity, image:  image,productCategoryId:cat,productId:pra,stock: stock));
    update();
}
void removeShoppingProduct(int index){
  shoppingProductList.removeAt(index);
    update();
}
 int checkShoppingProductIndex(String inPut) {
    for(var element in shoppingProductList){
      if(element.productName == inPut){
        return shoppingProductList.indexOf(element);
      }
    }
    return -1;
  }

  Future checkTotalCartProduct() async{
    totalProduct =0;
    totalPrice =0;
    for(var element in shoppingProductList) {
      totalProduct = totalProduct +element.quantity;
      totalPrice = totalPrice + element.price;
    }
    update();
  }

  Future clearCart() async {
    totalPrice = 0;
    totalProduct = 0;
    shoppingProductList.clear();
    update();
  }


   Future saveLocalProductKey(String key) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString("productKey", key.trim());
     update();
   }
   Future getLocalProductKey() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     if(prefs.containsKey("productKey")){
       key = (await prefs.getString("productKey"))!;
      await readProductData(key);
     }
    update();
   }
  void showException({required String status, required String message}) {
    Get.snackbar(status, message, duration: (const Duration(seconds: 2)),
        snackPosition: SnackPosition.BOTTOM,
        colorText: AppColors.primaryWhiteColor,
        backgroundColor: AppColors.blackColor.withOpacity(0.5),
        margin: const EdgeInsets.only(bottom: 30),
        maxWidth: Get.width * 0.8
    );}
}