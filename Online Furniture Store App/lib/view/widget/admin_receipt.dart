import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constant/app_color/app_color.dart';
import '../../firebase/cloud_firestore.dart';
import '../../model/customer_shopping_model.dart';
import 'custom_text.dart';

Widget AdminReceipt({required int temp ,required String id,required String date,required String totalPrice,required String totalProduct,required String status,required List<Products> shoppingProductList,required String uid}) {
  String today = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String yesterday=DateFormat('dd-MM-yyyy').format(DateTime.now().subtract(Duration(days: 1)));
  String current = date.substring(date.indexOf("/")+2,date.length);
  if(temp == 0 ){
    return
      current==today ?
      Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.blackColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 5,right: 5,bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                    color: AppColors.maroonColor,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: customText(text: "Date Time  - - - -  $date ", color: AppColors.primaryWhiteColor,
                    size: 15, fontWeight: FontWeight.normal),
              ),
            ),
            Divider(
              thickness: 1,
              color: AppColors.maroonColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customText(text: "Order ID  - - - -", color: AppColors.blackColor,
                    size: 15, fontWeight: FontWeight.normal),
                SizedBox(width: 10,),
                customText(text: id, color: AppColors.blackColor.withOpacity(0.5),
                    size: 15, fontWeight: FontWeight.normal),
              ],),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customText(text: "Total Price  - - - -", color: AppColors.blackColor,
                    size: 15, fontWeight: FontWeight.normal),
                SizedBox(width: 10,),
                customText(text: "${totalPrice} \$", color: AppColors.blackColor.withOpacity(0.5),
                    size: 15, fontWeight: FontWeight.normal),
              ],),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customText(text: "Total Product  - - - -", color: AppColors.blackColor,
                    size: 15, fontWeight: FontWeight.normal),
                SizedBox(width: 10,),
                customText(text: totalProduct, color: AppColors.blackColor.withOpacity(0.5),
                    size: 15, fontWeight: FontWeight.normal),
              ],),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customText(text: "Order Status  - - - -", color: AppColors.blackColor,
                    size: 15, fontWeight: FontWeight.normal),
                SizedBox(width: 10,),
                customText(text: status, color: AppColors.blackColor.withOpacity(0.5),
                    size: 15, fontWeight: FontWeight.normal),
              ],),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                    onTap: () async {
                      ShoppingDataModel shoppingDataModel =
                      ShoppingDataModel(products: shoppingProductList,
                          time: date,
                          totalPrice:totalPrice ,
                          totalProduct: totalProduct,
                          status: "Order Confirm");
                      await  CloudFirestoreServices().updateOrderStatus( order: shoppingDataModel, uid: uid, orderId: id);
                    },
                    child:  Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: status == "Order Confirm" ? AppColors.pakistanGreenColor : AppColors.greyColor ,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: customText(text: "Order Confirm", color: AppColors.primaryWhiteColor, size: 10, fontWeight: FontWeight.normal),
                      ),
                    ),

                  ),
                  InkWell(
                    overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                    onTap: () async {
                      ShoppingDataModel shoppingDataModel =
                      ShoppingDataModel(products: shoppingProductList,
                          time: date,
                          totalPrice:totalPrice ,
                          totalProduct: totalProduct,
                          status: "Order Declined");
                      await  CloudFirestoreServices().updateOrderStatus( order: shoppingDataModel, uid: uid, orderId: id);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                         color: status == "Order Declined" ? AppColors.pakistanGreenColor : AppColors.greyColor ,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: customText(text: "Order Declined", color: AppColors.primaryWhiteColor, size: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  InkWell(
                    overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                    onTap: () async {
                      ShoppingDataModel shoppingDataModel =
                      ShoppingDataModel(products: shoppingProductList,
                          time: date,
                          totalPrice:totalPrice ,
                          totalProduct: totalProduct,
                          status: "Order Padding");
                      await  CloudFirestoreServices().updateOrderStatus( order: shoppingDataModel, uid: uid, orderId: id);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: status == "Order Padding" ? AppColors.pakistanGreenColor : AppColors.greyColor ,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: customText(text: "Order Padding", color: AppColors.primaryWhiteColor, size: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  InkWell(
                    overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                    onTap: () async {
                      ShoppingDataModel shoppingDataModel =
                      ShoppingDataModel(products: shoppingProductList,
                          time: date,
                          totalPrice:totalPrice ,
                          totalProduct: totalProduct,
                          status: "Order Complete");
                      await  CloudFirestoreServices().updateOrderStatus( order: shoppingDataModel, uid: uid, orderId: id);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: status == "Order Complete" ? AppColors.pakistanGreenColor : AppColors.greyColor ,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: customText(text: "Order Complete", color: AppColors.primaryWhiteColor, size: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ) :Container();
  }else if(temp == 1  ) {
    return
      current==yesterday ?
      Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.blackColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 5,right: 5,bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                    color: AppColors.maroonColor,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: customText(text: "Date Time  - - - -  $date ", color: AppColors.primaryWhiteColor,
                    size: 15, fontWeight: FontWeight.normal),
              ),
            ),
            Divider(
              thickness: 1,
              color: AppColors.maroonColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customText(text: "Order ID  - - - -", color: AppColors.blackColor,
                    size: 15, fontWeight: FontWeight.normal),
                SizedBox(width: 10,),
                customText(text: id, color: AppColors.blackColor.withOpacity(0.5),
                    size: 15, fontWeight: FontWeight.normal),
              ],),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customText(text: "Total Price  - - - -", color: AppColors.blackColor,
                    size: 15, fontWeight: FontWeight.normal),
                SizedBox(width: 10,),
                customText(text: "${totalPrice} \$", color: AppColors.blackColor.withOpacity(0.5),
                    size: 15, fontWeight: FontWeight.normal),
              ],),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customText(text: "Total Product  - - - -", color: AppColors.blackColor,
                    size: 15, fontWeight: FontWeight.normal),
                SizedBox(width: 10,),
                customText(text: totalProduct, color: AppColors.blackColor.withOpacity(0.5),
                    size: 15, fontWeight: FontWeight.normal),
              ],),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customText(text: "Order Status  - - - -", color: AppColors.blackColor,
                    size: 15, fontWeight: FontWeight.normal),
                SizedBox(width: 10,),
                customText(text: status, color: AppColors.blackColor.withOpacity(0.5),
                    size: 15, fontWeight: FontWeight.normal),
              ],),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                    onTap: () async {
                      ShoppingDataModel shoppingDataModel =
                      ShoppingDataModel(products: shoppingProductList,
                          time: date,
                          totalPrice:totalPrice ,
                          totalProduct: totalProduct,
                          status: "Order Confirm");
                      await  CloudFirestoreServices().updateOrderStatus( order: shoppingDataModel, uid: uid, orderId: id);
                    },
                    child:  Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: status == "Order Confirm" ? AppColors.pakistanGreenColor : AppColors.greyColor ,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: customText(text: "Order Confirm", color: AppColors.primaryWhiteColor, size: 10, fontWeight: FontWeight.normal),
                      ),
                    ),

                  ),
                  InkWell(
                    overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                    onTap: () async {
                      ShoppingDataModel shoppingDataModel =
                      ShoppingDataModel(products: shoppingProductList,
                          time: date,
                          totalPrice:totalPrice ,
                          totalProduct: totalProduct,
                          status: "Order Declined");
                      await  CloudFirestoreServices().updateOrderStatus( order: shoppingDataModel, uid: uid, orderId: id);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: status == "Order Declined" ? AppColors.pakistanGreenColor : AppColors.greyColor ,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: customText(text: "Order Declined", color: AppColors.primaryWhiteColor, size: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),

                  InkWell(
                    overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                    onTap: () async {
                      ShoppingDataModel shoppingDataModel =
                      ShoppingDataModel(products: shoppingProductList,
                          time: date,
                          totalPrice:totalPrice ,
                          totalProduct: totalProduct,
                          status: "Order Padding");
                      await  CloudFirestoreServices().updateOrderStatus( order: shoppingDataModel, uid: uid, orderId: id);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: status == "Order Padding" ? AppColors.pakistanGreenColor : AppColors.greyColor ,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: customText(text: "Order Padding", color: AppColors.primaryWhiteColor, size: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  InkWell(
                    overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                    onTap: () async {
                      ShoppingDataModel shoppingDataModel =
                      ShoppingDataModel(products: shoppingProductList,
                          time: date,
                          totalPrice:totalPrice ,
                          totalProduct: totalProduct,
                          status: "Order Complete");
                      await  CloudFirestoreServices().updateOrderStatus( order: shoppingDataModel, uid: uid, orderId: id);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: status == "Order Complete" ? AppColors.pakistanGreenColor : AppColors.greyColor ,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: customText(text: "Order Complete", color: AppColors.primaryWhiteColor, size: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ) : Container();
  }else{
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.blackColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(top: 5,right: 5,bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              decoration: BoxDecoration(
                  color: AppColors.maroonColor,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: customText(text: "Date Time  - - - -  $date ", color: AppColors.primaryWhiteColor,
                  size: 15, fontWeight: FontWeight.normal),
            ),
          ),
          Divider(
            thickness: 1,
            color: AppColors.maroonColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              customText(text: "Order ID  - - - -", color: AppColors.blackColor,
                  size: 15, fontWeight: FontWeight.normal),
              SizedBox(width: 10,),
              customText(text: id, color: AppColors.blackColor.withOpacity(0.5),
                  size: 15, fontWeight: FontWeight.normal),
            ],),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              customText(text: "Total Price  - - - -", color: AppColors.blackColor,
                  size: 15, fontWeight: FontWeight.normal),
              SizedBox(width: 10,),
              customText(text: "${totalPrice} \$", color: AppColors.blackColor.withOpacity(0.5),
                  size: 15, fontWeight: FontWeight.normal),
            ],),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              customText(text: "Total Product  - - - -", color: AppColors.blackColor,
                  size: 15, fontWeight: FontWeight.normal),
              SizedBox(width: 10,),
              customText(text: totalProduct, color: AppColors.blackColor.withOpacity(0.5),
                  size: 15, fontWeight: FontWeight.normal),
            ],),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              customText(text: "Order Status  - - - -", color: AppColors.blackColor,
                  size: 15, fontWeight: FontWeight.normal),
              SizedBox(width: 10,),
              customText(text: status, color: AppColors.blackColor.withOpacity(0.5),
                  size: 15, fontWeight: FontWeight.normal),
            ],),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                  onTap: () async {
                    ShoppingDataModel shoppingDataModel =
                    ShoppingDataModel(products: shoppingProductList,
                        time: date,
                        totalPrice:totalPrice ,
                        totalProduct: totalProduct,
                        status: "Order Confirm");
                    await  CloudFirestoreServices().updateOrderStatus( order: shoppingDataModel, uid: uid, orderId: id);
                  },
                  child:  Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: status == "Order Confirm" ? AppColors.pakistanGreenColor : AppColors.greyColor ,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: customText(text: "Order Confirm", color: AppColors.primaryWhiteColor, size: 10, fontWeight: FontWeight.normal),
                      ),
                    ),

                ),
                InkWell(
                  overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                  onTap: () async {
                    ShoppingDataModel shoppingDataModel =
                    ShoppingDataModel(products: shoppingProductList,
                        time: date,
                        totalPrice:totalPrice ,
                        totalProduct: totalProduct,
                        status: "Order Declined");
                    await  CloudFirestoreServices().updateOrderStatus( order: shoppingDataModel, uid: uid, orderId: id);
                  },
                  child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: status == "Order Declined" ? AppColors.pakistanGreenColor : AppColors.greyColor ,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: customText(text: "Order Declined", color: AppColors.primaryWhiteColor, size: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                ),

               InkWell(
                 overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                 onTap: () async {
                   ShoppingDataModel shoppingDataModel =
                   ShoppingDataModel(products: shoppingProductList,
                       time: date,
                       totalPrice:totalPrice ,
                       totalProduct: totalProduct,
                       status: "Order Padding");
                   await  CloudFirestoreServices().updateOrderStatus( order: shoppingDataModel, uid: uid, orderId: id);
                 },
                 child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: status == "Order Padding" ? AppColors.pakistanGreenColor : AppColors.greyColor ,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: customText(text: "Order Padding", color: AppColors.primaryWhiteColor, size: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
               ),
                InkWell(
                  overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                  onTap: () async {
                    ShoppingDataModel shoppingDataModel =
                    ShoppingDataModel(products: shoppingProductList,
                        time: date,
                        totalPrice:totalPrice ,
                        totalProduct: totalProduct,
                        status: "Order Complete");
                    await  CloudFirestoreServices().updateOrderStatus( order: shoppingDataModel, uid: uid, orderId: id);
                  },
                  child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: status == "Order Complete" ? AppColors.pakistanGreenColor : AppColors.greyColor ,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: customText(text: "Order Complete", color: AppColors.primaryWhiteColor, size: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}