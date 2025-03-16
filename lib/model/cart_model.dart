import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  bool status;
  String message;
  List<Order> order;

  CartModel({
    required this.status,
    required this.message,
    required this.order,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        status: json["status"],
        message: json["message"],
        order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "order": List<dynamic>.from(order.map((x) => x.toJson())),
      };
}

class Order {
  String id;
  String uid;
  String pid;
  String pname;
  String ppic;
  String date;
  String time;
  String amount;
  String totalAmount;
  String quantity;
  String status;
  String isWishlist;
  String address;
  String paymentType;
  String state;

  Order({
    required this.id,
    required this.uid,
    required this.pid,
    required this.pname,
    required this.ppic,
    required this.date,
    required this.time,
    required this.amount,
    required this.totalAmount,
    required this.quantity,
    required this.status,
    required this.isWishlist,
    required this.address,
    required this.paymentType,
    required this.state,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        uid: json["uid"],
        pid: json["pid"],
        pname: json["pname"],
        ppic: json["ppic"],
        date: json["date"],
        time: json["time"],
        amount: json["amount"],
        totalAmount: json["total_amount"],
        quantity: json["quantity"],
        status: json["status"],
        isWishlist: json["is_wishlist"],
        address: json["address"],
        paymentType: json["payment_type"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "pid": pid,
        "pname": pname,
        "ppic": ppic,
        "date": date,
        "time": time,
        "amount": amount,
        "total_amount": totalAmount,
        "quantity": quantity,
        "status": status,
        "is_wishlist": isWishlist,
        "address": address,
        "payment_type": paymentType,
        "state": state,
      };
}
