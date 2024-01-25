import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/app_color/app_color.dart';
import '../../../controller/data_controller.dart';
import '../../widget/custom_loader.dart';
import '../../widget/custom_text.dart';
import 'admin_order_screen.dart';
class admin_allUser_screen extends StatefulWidget {
  const admin_allUser_screen({Key? key}) : super(key: key);

  @override
  State<admin_allUser_screen> createState() => _admin_allUser_screenState();
}

class _admin_allUser_screenState extends State<admin_allUser_screen> {
  late DataController _dataController;
  void initState() {
    try {
      _dataController = Get.find();
    } catch (exception) {
      _dataController = Get.put(DataController());
    }
    _dataController.readAllOrders();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText(text: "Customer List", color: AppColors.primaryWhiteColor, size: 20, fontWeight: FontWeight.bold),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
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
       return StreamBuilder<QuerySnapshot>(
           stream:_dataController.allOrders ,
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
                physics: BouncingScrollPhysics(),
                 children: snapshot.data!.docs.map((DocumentSnapshot document) {
                   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                   return
                     Container(
                         margin: EdgeInsets.all(5),
                         padding: EdgeInsets.all(5),
                         decoration: BoxDecoration(
                           color: AppColors.maroonColor.withOpacity(0.5),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             SizedBox(height: 5,),
                             customText(text: "Customer Name  - - -   ${data['name']}", color: AppColors.blackColor, size: 15, fontWeight: FontWeight.bold),
                             SizedBox(height: 5,),
                             Divider(color: AppColors.primaryWhiteColor,thickness: 1,),
                             customText(text:"Email  - - -   ${ data['email']}", color: AppColors.blackColor, size: 15, fontWeight: FontWeight.bold),
                             SizedBox(height: 5,),
                             Divider(color: AppColors.primaryWhiteColor,thickness: 1,),
                             customText(text: "ID - - -  ${document.id}", color: AppColors.blackColor, size: 15, fontWeight: FontWeight.bold),
                             SizedBox(height: 5,),
                             Divider(color: AppColors.primaryWhiteColor,thickness: 1,),
                             InkWell(
                               overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                                onTap: () async {
                                 await _dataController.readCurrentUserOrders(document.id);
                                 Get.to(() => AdminOrderScreen(id:document.id));
                               },
                               child: Center(
                                 child: Container(
                                   height: 40,
                                   width: 100,
                                   decoration: BoxDecoration(
                                       color: AppColors.maroonColor,
                                       borderRadius: BorderRadius.circular(20)
                                   ),
                                   child: Center(
                                     child: customText(text: "Orders List", color: AppColors.primaryWhiteColor, size: 15, fontWeight: FontWeight.bold),
                                   ),
                                 ),
                               ),
                             )
                           ],
                         ));
                 }).toList());
           }
       );
      }),
    );
  }
}
