import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/constant/assets_path/animation_path.dart';
import 'package:pos/view/widget/custom_animation.dart';
import '../../../constant/app_color/app_color.dart';
import '../../../controller/data_controller.dart';
import '../../widget/custom_icon.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_loader.dart';
import '../../widget/custom_text.dart';
import 'cart_screen.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
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
    await _dataController.readProductCategoryData();
    await  _dataController.readProductData(_dataController.key);
    setState((){
      categoryKey = _dataController.key;
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
          automaticallyImplyLeading: false,
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
                   await  _dataController.checkTotalCartProduct();
                    Get.to(() => CartScreen());
                  },
                  child: customAnimation(animation: AppAnimationPath.cart, height: 20, width: 50)),
            )
          ],
        ),
        body:
        GetBuilder<DataController>(builder: (_) {
          return  SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                customAnimation(animation: AppAnimationPath.shopping, height: 150, width: double.infinity),
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
                      if(categoryKey.isEmpty || categoryKey == "" ){
                        Future.delayed(Duration(seconds: 1),(){
                          setState((){
                            categoryKey = snapshot.data!.docs.first.id;
                            _dataController.saveLocalProductKey(categoryKey);
                            _dataController.readProductData(categoryKey);
                          });
                        });
                      }
                      return Wrap(
                        runSpacing: 5,
                        spacing: 5,
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            return InkWell(
                              overlayColor:MaterialStateProperty.all(AppColors.transparentColor) ,
                              onTap: () {
                                setState((){
                                  categoryKey = document.id;
                                  _dataController.saveLocalProductKey(document.id);
                                  _dataController.readProductData(document.id);
                                });
                              },
                              child: FittedBox(
                                child: SizedBox(
                                    height: 50,
                                   // width: 80,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      color:categoryKey != document.id ? AppColors.pakistanGreenColor:AppColors.orangeColor,
                                      elevation: 5,
                                      borderOnForeground: true,
                                      shadowColor: AppColors.primaryWhiteColor,
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: customText(
                                              text: data['productCategory'],
                                              color: AppColors.primaryWhiteColor,
                                              size: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                              ),
                            );
                          }).toList());
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
                                          text: "There is ana error",
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
                        return
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                              String imageUrl = data["image"] ;
                              imageUrl = imageUrl.replaceAll( RegExp(r'(\?alt).*'), '');
                              imageUrl = imageUrl.replaceAll( RegExp(r'https://firebasestorage.googleapis.com/v0/b/mobile-app-for-pos.appspot.com/o/'), '');
                              imageUrl = imageUrl.replaceAll( RegExp(r'(%2F)'), '/');
                              int index= _dataController.checkShoppingProductIndex(data["product"]);
                              return  Padding(
                                padding: const EdgeInsets.all(5),
                                child: SizedBox(
                                    height: 150,
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
                                                child: customNetworkImage(image: data["image"],height:150 ,width: 100)),
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
                                                      customText(text: "Available =  ${data["quantity"]}", color: AppColors.primaryWhiteColor, size: 15, fontWeight: FontWeight.bold),
                                                    ],
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                        overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                                                        onTap: () async {
                                                          if(index>=0){
                                                            if(int.parse(data["quantity"]) > _dataController.shoppingProductList[index].quantity)
                                                            {
                                                              setState(() {
                                                                _dataController.shoppingProductList[index].quantity ++;
                                                                _dataController.shoppingProductList[index].price =  _dataController.shoppingProductList[index].price + double.parse(data["price"]);
                                                              });
                                                            }
                                                            else{
                                                              _dataController.showException(status: "Sorry ", message: "Stock limit reached");
                                                            }

                                                          }
                                                          else if(categoryKey.isNotEmpty){
                                                            _dataController.addShoppingProduct(name:data["product"] ,price: double.parse(data["price"]),quantity: 1,image: data["image"],cat: categoryKey,pra: document.id,stock: data["quantity"]);
                                                          }
                                                          else{
                                                            _dataController.showException(status: "Warning", message: "Select Product Category");
                                                          }
                                                        },
                                                        child:Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                                color: AppColors.blackColor,
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            child: Center(child: customIcon(icon: Icons.add, size: 20, color: AppColors.primaryWhiteColor)))),
                                                    const SizedBox(height: 5,),
                                                    customText(text:index>=0 ?_dataController.shoppingProductList[index].quantity.toString():"0", color: AppColors.primaryWhiteColor, size: 20, fontWeight: FontWeight.bold),
                                                    const SizedBox(height: 5,),
                                                    InkWell(
                                                        overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                                                        onTap: () async{
                                                          if(index>=0){
                                                            if(_dataController.shoppingProductList[index].quantity >0){
                                                              setState(() {
                                                                _dataController.shoppingProductList[index].quantity --;
                                                                _dataController.shoppingProductList[index].price =  _dataController.shoppingProductList[index].price - double.parse(data["price"]);
                                                              });
                                                            }
                                                            else{
                                                              _dataController.removeShoppingProduct(index);
                                                            }
                                                          }
                                                        },
                                                        child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                                color: AppColors.blackColor,
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            child: Center(child: customIcon(icon: Icons.remove, size: 20, color: AppColors.primaryWhiteColor)))),
                                                  ],
                                                ))
                                          ],
                                        )
                                    )),
                              );
                            }).toList());
                      }
                    }
                ) ],
            ),
          );
        }),
    );
  }
}
