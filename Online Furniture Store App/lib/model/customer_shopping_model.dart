class ShoppingDataModel {
  late  List<Products> products;
  late  String time;
  late  String totalPrice;
  late String totalProduct;
  late  String status;
  ShoppingDataModel({required this.totalProduct,required this.products,required this.time,required this.totalPrice,required this.status});
   ShoppingDataModel.fromJson(dynamic json) {
     totalProduct = json["totalProduct"];
     if (json['products'] != null) {
       products = [];
         json['products'].forEach((v) {
           products.add(Products.fromJson(v));
         });
     }
     time= json['time'];
     totalPrice= json['totalPrice'];
     status= json['status'];
   }
  Map<String, dynamic> toJson()  {
    final map = <String, dynamic>{};
    map[ "totalProduct"]= totalProduct;
    map['products'] = products.map((v) => v.toJson()).toList();
    map[ "time"]= time;
    map[ "totalPrice"]= totalPrice;
    map[ "status"]= status;
    return map;
  }
}
class Products{
 late String productName;
 late  double price;
 late  int quantity;
 late  String image;
 late  String productId;
 late  String productCategoryId;
 late  String stock;

  Products({required this.productName,required this.price,required this.quantity,required this.image, required this.productCategoryId,required this.productId,required this.stock});
   Products.fromJson(dynamic json) {
     productName= json["productName"];
     price= json['price'];
     quantity= json['quantity'];
     image= json['image'];
     productId= json['productId'];
     productCategoryId= json['productCategoryId'];
     stock= json['stock'];
   }
  Map<String, dynamic> toJson()  {
    final map = <String, dynamic>{};
   map[ "productName"]= productName;
   map[ "price"]= price;
   map[ "quantity"]= quantity;
   map[ "image"]= image;
   map[ "productId"]= productId;
   map[ "productCategoryId"]= productCategoryId;
   map[ "stock"]= stock;
   return map;
  }
}