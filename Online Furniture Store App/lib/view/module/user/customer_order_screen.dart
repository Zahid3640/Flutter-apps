import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/view/widget/customer_receipt.dart';

import '../../../constant/app_color/app_color.dart';
import '../../../constant/assets_path/animation_path.dart';
import '../../../controller/data_controller.dart';
import '../../widget/custom_animation.dart';
import '../../widget/custom_loader.dart';
import '../../widget/custom_text.dart';

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({Key? key}) : super(key: key);

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  List<String> orderText = ["Today", "Yesterday", "All"];
  int temp = 2;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText(text: "Order List",
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
      ),
      body:
      GetBuilder<DataController>(builder: (_){
        return  SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customAnimation(animation: AppAnimationPath.shopping, height: 150, width: double.infinity),
                Center(
                  child: SizedBox(
                    height: 60,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: orderText.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  temp = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: temp == index
                                      ? AppColors.maroonColor
                                      : AppColors.blackColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: customText(
                                    text: orderText[index],
                                    color: AppColors.primaryWhiteColor,
                                    size: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream:_dataController.currentUserOrders ,
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
                      return  ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                              return
                                 CustomerReceipt(temp: temp,  id: document.id, date: data["order"]["time"], totalPrice: data["order"]["totalPrice"], totalProduct: data["order"]["totalProduct"],status:data["order"]["status"] );
                            }).toList());
                    }
                ),
              ],
          ),
        );
      }),

    );
  }
}
