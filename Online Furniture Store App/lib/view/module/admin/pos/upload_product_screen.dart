import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant/app_color/app_color.dart';
import '../../../../controller/data_controller.dart';
import '../../../../firebase/cloud_firestore.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/custom_textFormField.dart';
import 'dart:io';
class ProductUploadScreen extends StatefulWidget {
 final String categoryKey;
 final String productKey;
 final String imageUrl;
   ProductUploadScreen({Key? key,required this.categoryKey,required this.productKey,required this.imageUrl}) : super(key: key);

  @override
  State<ProductUploadScreen> createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController =TextEditingController();
  TextEditingController priceController =TextEditingController();
  TextEditingController quantityController =TextEditingController();
  late DataController _dataController;
  @override
  void initState() {
    try {
      _dataController = Get.find();
    } catch (exception) {
      _dataController = Get.put(DataController());
    }
    super.initState();
  }
  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
      GetBuilder<DataController>(builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: customText(
                text:widget.productKey.isEmpty ? "Add Product" : "Update Product",
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
          body:  Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customTextFormField(textEditingController: nameController,hintText: "Enter Product Name",obscureText: false,email:false,onchange: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }),
                    customIntegerFormField(textEditingController: priceController,hintText: "Enter Product Price",onchange: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }),
                    customIntegerFormField(textEditingController: quantityController,hintText: "Enter Product Quantity",onchange: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }),
                    const SizedBox(height: 30,),
                   !_dataController.isImageSelected ?
                    InkWell(
                      overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                      onTap: ()  {
                        _dataController.pickImageFromGallery();
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: AppColors.orangeColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: customText(text: "Select Image", color: AppColors.blackColor, size: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ):
                    Image.file(File(_dataController.imageFile!.path),height: 100,width: 100,fit: BoxFit.fill,),
                    const SizedBox(height: 30,),
                    _dataController.isImageUploaded ?
                    InkWell(
                      overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                      onTap: () async {
                        if(_formKey.currentState!.validate() && widget.categoryKey.isNotEmpty){
                          if(widget.productKey.isEmpty) {
                            await CloudFirestoreServices().addProduct(key:widget.categoryKey.toString(),name: nameController.text.trim(),price: priceController.text.trim(),
                                quantity: quantityController.text.trim(),imageUrl: _dataController.imageUrl
                            );
                          }
                          else {
                            await  FirebaseStorage.instance.ref().child(widget.imageUrl).delete();
                            await CloudFirestoreServices().updateProduct(productCatkey:widget.categoryKey.toString(),productKey:widget.productKey.toString(),name: nameController.text.trim(),price: priceController.text.trim(),
                                quantity: quantityController.text.trim(),imageUrl: _dataController.imageUrl
                            );
                          }
                          _dataController.clearSelectedImage();
                          Get.back();
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 150,
                        decoration: BoxDecoration(
                            color: AppColors.pakistanGreenColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: customText(text: "Submit Product", color: AppColors.primaryWhiteColor, size: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ) :
                    InkWell(
                      overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                      onTap: ()  async {
                        _dataController.showException(status: "Uploading",message: "Product Image");
                        await  _dataController.uploadProductImage(image: _dataController.imageFile);
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: AppColors.orangeColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: customText(text: "Upload Image", color: AppColors.blackColor, size: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
  }
}
