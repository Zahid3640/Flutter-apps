import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/constant/assets_path/animation_path.dart';
import 'package:pos/view/widget/custom_animation.dart';
import '../../../constant/app_color/app_color.dart';
import '../../../controller/data_controller.dart';
import '../../../firebase/cloud_firestore.dart';
import '../../../model/customer_shopping_model.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_text.dart';
import 'package:intl/intl.dart';

import 'customer_homeScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late DataController _dataController;
  DateTime now =  DateTime.now();
  int quantity=0;
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
      backgroundColor: AppColors.primaryWhiteColor,
      appBar: AppBar(
        title: customText(
            text: "Cart",
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
      body: GetBuilder<DataController>(builder: (_) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                  itemCount: _dataController.shoppingProductList.length,
                  itemBuilder: (BuildContext context ,int index) {
                return  Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                      height: 130,
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
                                  child: customNetworkImage(image:_dataController.shoppingProductList[index].image,height:130 ,width: 100)),
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        customText(text: _dataController.shoppingProductList[index].productName, color: AppColors.primaryWhiteColor, size: 15, fontWeight: FontWeight.bold),
                                        customText(text:"Quantity = ${ _dataController.shoppingProductList[index].quantity.toString()}", color: AppColors.primaryWhiteColor, size: 15, fontWeight: FontWeight.bold),
                                        customText(text: "Total Price = ${_dataController.shoppingProductList[index].price.toString()} \$", color: AppColors.primaryWhiteColor, size: 15, fontWeight: FontWeight.bold),
                                      ],
                                    ),
                                  )),
                            ],
                          )
                      )),
                );
              }),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 10,right: 10,bottom: 50),
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.tealColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  customText(text: "Total Product = ${_dataController.totalProduct.toString()}", color: AppColors.blackColor,
                      size: 20, fontWeight: FontWeight.bold),
                  customText(text: "Total Price = ${_dataController.totalPrice.toString()} \$", color: AppColors.blackColor,
                      size: 20, fontWeight: FontWeight.bold),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: customText(text: "${DateFormat('hh-mm - a / dd-MM-yyyy').format(now)}", color: AppColors.blackColor,
                        size: 10, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ),
            )
          ],
        );
      }),
      floatingActionButton: SizedBox(
        height: 40,
        width: 180,
        child: FloatingActionButton(
          onPressed: () async {
            ShoppingDataModel shoppingDataModel =
            ShoppingDataModel(products: List<Products>.from(
                _dataController.shoppingProductList),
                time: "${DateFormat('hh-mm - a / dd-MM-yyyy').format(now)}",
                totalPrice: _dataController.totalPrice.toString(),
                totalProduct: _dataController.totalProduct.toString(),
                status: "Order Placed");
            await  CloudFirestoreServices().placeOrder( order: shoppingDataModel);
            await CloudFirestoreServices() .addOrderToAdminPanel(order: "${_dataController.totalOrders+1}", price: "${_dataController.totalOrdersPrice +_dataController.totalPrice}");
            for(var element in _dataController.shoppingProductList) {
              quantity = int.parse(element.stock) - element.quantity;
              await CloudFirestoreServices().updateProductStock(productCatkey: element.productCategoryId, productKey: element.productId,quantity:quantity.toString()) ;
            }
            await _dataController.clearCart();
            Get.off(() =>UserHomeScreen());
          },
          elevation: 10,
          splashColor: AppColors.primaryWhiteColor.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: AppColors.orangeColor,
          child:Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customText(text: "Confirm Order", color: AppColors.primaryWhiteColor, size: 15, fontWeight: FontWeight.bold),
                customAnimation(animation: AppAnimationPath.confirmOrder, height: 50, width: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
