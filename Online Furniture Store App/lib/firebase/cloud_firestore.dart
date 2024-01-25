import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../constant/app_color/app_color.dart';
import '../controller/authentication_helper.dart';
import '../model/customer_shopping_model.dart';


class CloudFirestoreServices {
  static final CloudFirestoreServices _cloudFirestoreServices = CloudFirestoreServices._internal();
  factory CloudFirestoreServices() {
    return _cloudFirestoreServices;
  }
  CloudFirestoreServices._internal();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Future addAdmin() async {
    CollectionReference admin = fireStore.collection('admin');
    await  admin.add(({
      'name':"Muhammad Yousaf",
      'mail':"muhammadyousafg51@gmail.com",
      "password":"Yousaf@753"
    })).then((value) {
      showException(status: 'Successful', message: 'Admin added');
    }).catchError((error) {
      showException(status: 'Failed', message: error.toString());
    });
  }
  Future<bool> getAdmin({required String email, required String password}) async {
    return fireStore.collection("admin").doc("0AbmqfPLgA6gx3WNH4Rz").get().then(( querySnapshot) {
      Map<String, dynamic> data = querySnapshot.data() as Map<String, dynamic>;
      var emailData = data["mail"];
      var passwordData= data["password"];
      if(email == emailData && password == passwordData) {
        return true;
      }
      else {
        return false;
      }
    });
  }

  Future deleteUser(String userID) async{
    return fireStore
        .collection("users")
        .doc(userID)
        .delete();
  }
  Future<void> addUser({required String name, required email,required String password}) {
    CollectionReference users = fireStore.collection('users');
    return users.doc(AuthenticationHelper().user.uid).set
      ({'name': name, 'email': email,'password':password}).then((value) {
       showException(status: "Successful", message: "User Added");
    }).catchError((error) {
      showException(status: "Failed", message: error);
    });
  }

  Future<Stream<DocumentSnapshot>> readAdminInfo () async{
    final Stream<DocumentSnapshot> admin = fireStore.collection('admin').doc("0AbmqfPLgA6gx3WNH4Rz").snapshots() ;
    return admin;
  }

  Future<Stream<DocumentSnapshot>> readUserInfo () async{
    final Stream<DocumentSnapshot> admin = fireStore.collection('users').doc(AuthenticationHelper().user.uid).snapshots() ;
    return admin;
  }
// region order
  Future placeOrder({required ShoppingDataModel order}) async {
    CollectionReference orderRef = fireStore.collection('users').doc(AuthenticationHelper().user.uid).collection("order");
    return orderRef.add
      ({'order': order.toJson(), }).then((value) {
      showException(status:"Successful" ,message: "Order Placed");
    }).catchError((error) {
      showException(status:"Failed" ,message: error);
    });
  }
  Future updateOrderStatus({required ShoppingDataModel order,required String uid,required String orderId}) async {
    CollectionReference orderRef = fireStore.collection('users').doc(uid).collection("order");
    return orderRef.doc(orderId).update
      ({'order': order.toJson(), }).then((value) {
      showException(status:"Successful" ,message: "Order Status Update");
    }).catchError((error) {
      showException(status:"Failed" ,message: error);
    });
  }

  Future  addOrderToAdminPanel ({required String order,required String price}) async{
    CollectionReference productCategoryRef = fireStore.collection('admin').doc("0AbmqfPLgA6gx3WNH4Rz").collection("order_count");
    productCategoryRef.doc("orders").set(({
      "total_price":price.trim(),
      "total_orders":order.trim(),
    }));
  }

  Future<Stream<DocumentSnapshot>> readOrderCount () async{
    final Stream<DocumentSnapshot> orders = fireStore.collection('admin').doc("0AbmqfPLgA6gx3WNH4Rz").collection("order_count").doc("orders").snapshots() ;
    return orders;
  }

  Future<Stream<QuerySnapshot>> readCurrentUserOrder (String uid) async {
    final Stream<QuerySnapshot> orders = fireStore.collection('users').doc(uid).collection("order").snapshots();
    return orders;
  }
  Future<Stream<QuerySnapshot>> readAllOrder () async {
    final Stream<QuerySnapshot> orders = fireStore.collection('users').snapshots();
    return orders;
  }

  //endregion

  //region admin product Category
  Future  addProductCategory ({required String input}) async{
    CollectionReference productCategoryRef = fireStore.collection('admin').doc("0AbmqfPLgA6gx3WNH4Rz").collection("store");
    productCategoryRef.add(({
      "productCategory":input.trim()
    })).then((value) {
      showException(status: 'Successful', message: 'Product Category Added');
    }).catchError((error) {
      showException(status: 'Failed', message: error.toString());
    });
  }

  Future<Stream<QuerySnapshot>> readProductCategory () async {
    final Stream<QuerySnapshot> productCategory = fireStore.collection('admin').doc("0AbmqfPLgA6gx3WNH4Rz").collection("store").snapshots();
    return productCategory;
  }

  Future updateProductCategory ({required String key,required String input}) async {
    CollectionReference productCategoryRef = fireStore.collection('admin').doc("0AbmqfPLgA6gx3WNH4Rz").collection("store");
    productCategoryRef.doc(key.trim()).update({ "productCategory":input.trim()}).then((value) {
      showException(status: 'Successful', message: 'Product Category Update');
    }).catchError((error) {
      showException(status: 'Failed', message: error.toString());
    });

  }

  Future deleteProductCategory ({required String key}) async {
    CollectionReference productCategoryRef = fireStore.collection('admin').doc("0AbmqfPLgA6gx3WNH4Rz").collection("store");
    productCategoryRef.doc(key.trim()).delete().then((value) {
      showException(status: 'Successful', message: 'Product Category Delete');
    }).catchError((error) {
      showException(status: 'Failed', message: error.toString());
    });

  }
  //endregion

  //region admin product
  Future  addProduct ({required String key,required String name,required String price,required String quantity,required String imageUrl }) async{
    CollectionReference productRef = fireStore.collection('admin').doc("0AbmqfPLgA6gx3WNH4Rz").collection("store").doc(key).collection("products");
    productRef.add(({
      "product":name.trim(),
      "price":price.trim(),
      "quantity":quantity.trim(),
      "image":imageUrl,
    })).then((value) {
      showException(status: 'Successful', message: 'Product Added');
    }).catchError((error) {
      showException(status: 'Failed', message: error.toString());
    });
  }
  Future<Stream<QuerySnapshot>?> readProduct (String key) async {
    Stream<QuerySnapshot>? productCategory ;
    if(key.isNotEmpty){
      productCategory = fireStore.collection('admin').doc("0AbmqfPLgA6gx3WNH4Rz").collection("store").doc(key).collection("products").snapshots();
    }
    return productCategory;
  }

  Future deleteProduct ({required String productCatKey,required String productKey}) async {
    CollectionReference productCategoryRef = fireStore.collection('admin').doc("0AbmqfPLgA6gx3WNH4Rz").collection("store").doc(productCatKey.trim()).collection("products");
    productCategoryRef.doc(productKey.trim()).delete().then((value) {
      showException(status: 'Successful', message: 'Product Delete');
    }).catchError((error) {
      showException(status: 'Failed', message: error.toString());
    });

  }

  Future  updateProduct ({required String productCatkey,required String productKey,required String name,required String price,required String quantity,required String imageUrl }) async{
    CollectionReference productRef = fireStore.collection('admin').doc("0AbmqfPLgA6gx3WNH4Rz").collection("store").doc(productCatkey).collection("products");
    productRef.doc(productKey).update(({
      "product":name.trim(),
      "price":price.trim(),
      "quantity":quantity.trim(),
      "image":imageUrl,
    })).then((value) {
      showException(status: 'Successful', message: 'Product Update');
    }).catchError((error) {
      showException(status: 'Failed', message: error.toString());
    });
  }

  Future updateProductStock ({required String productCatkey,required String productKey,required String quantity}) async {

    CollectionReference productRef = fireStore.collection('admin').doc("0AbmqfPLgA6gx3WNH4Rz").collection("store").doc(productCatkey).collection("products");
    productRef.doc(productKey).update(({
      "quantity":quantity.trim(),
    }));
  }
  //endregion

  void showException({required String status, required String message}) {
    Get.snackbar(status, message, duration: (const Duration(seconds: 2)),
        snackPosition: SnackPosition.BOTTOM,
        colorText: AppColors.primaryWhiteColor,
        backgroundColor: AppColors.blackColor.withOpacity(0.5),
        margin: const EdgeInsets.only(bottom: 30),
        maxWidth: Get.width * 0.8
    );
  }
}