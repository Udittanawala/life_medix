import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:get/get.dart';
import 'package:life_medix_demo/controller/cart_controller.dart';
import 'package:life_medix_demo/generated/const_data.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final controller = Get.put(CartController());
  String selectedButton = "Button1"; // Default selection
  bool i = false;

  final Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    controller.getCartData();
    controller.pay_type = "COD"; // Default payment type

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.cyanAccent.shade100,
      ),
      body: Obx(
        () {
          if (controller.isload.value) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (controller.model == null ||
              controller.model!.order.isEmpty) {
            return _buildEmptyCart();
          } else {
            return _buildCartItems();
          }
        },
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.cyanAccent.shade100, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/images/empty_anim.json'),
          SizedBox(height: 40),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.health_and_safety,
                    color: Colors.cyan.shade600, size: 24),
                SizedBox(width: 8),
                Text(
                  "GET BUY MEDICINE",
                  style: TextStyle(
                    color: Colors.cyan.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCartItems() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOrderList(),
            const SizedBox(height: 20),
            _buildCouponSection(),
            const SizedBox(height: 20),
            _buildBillSummary(),
            const SizedBox(height: 20),
            _buildPaymentMethodSelection(),
            const SizedBox(height: 20),
            _buildCheckoutButton(),
            const SizedBox(height: 10),
            _buildInfoSection(),
            SizedBox(height: 60, width: double.infinity),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList() {
    return SizedBox(
      height: controller.model!.order.length < 3
          ? (130 * controller.model!.order.length).toDouble()
          : (130 * 3).toDouble(),
      child: ListView.builder(
        itemCount: controller.model!.order.length,
        itemBuilder: (context, index) {
          var data = controller.model!.order[index];
          return _buildOrderItem(data);
        },
      ),
    );
  }

  Widget _buildOrderItem(data) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      ConstantData.SERVER_ADDRESS_IMAGE + data.ppic,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.pname,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove,
                                        size: 20, color: Colors.cyan.shade700),
                                    onPressed: () {
                                      if (int.parse(data.quantity) > 1) {
                                        controller.updateQty(
                                            qty: (int.parse(data.quantity) - 1)
                                                .toString(),
                                            id: data.id,
                                            amount: data.amount);
                                      } else {
                                        controller.removeOrder(id: data.id);
                                      }
                                      controller.calculateAmount();
                                    },
                                  ),
                                  Text(
                                    data.quantity,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add,
                                        size: 20, color: Colors.cyan.shade700),
                                    onPressed: () {
                                      controller.updateQty(
                                          qty: (int.parse(data.quantity) + 1)
                                              .toString(),
                                          id: data.id,
                                          amount: data.amount);
                                      controller
                                          .calculateAmount(); // Recalculate amount
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "₹${data.totalAmount}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.cyan.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: IconButton(
                icon:
                    const Icon(Icons.delete, color: Colors.redAccent, size: 22),
                onPressed: () {
                  controller.removeOrder(id: data.id);
                  controller.calculateAmount(); // Recalculate amount
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponSection() {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter Coupon Code",
                  hintStyle:
                      TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.cyan, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.cyan, width: 2),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                ),
                controller: controller.couponController,
                textCapitalization: TextCapitalization.words,
                onChanged: (value) {
                  controller.removeCoupon();
                },
                focusNode: controller.focusNode,
                onTapOutside: (event) {
                  controller.focusNode.unfocus();
                },
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: controller.applyCoupon,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan.shade600,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 6,
                shadowColor: Colors.cyan.shade200,
              ),
              child: Row(
                children: [
                  Icon(Icons.local_offer, color: Colors.white, size: 20),
                  SizedBox(width: 6),
                  Text(
                    "APPLY",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillSummary() {
    return Container(
      decoration: BoxDecoration(),
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bill Summary",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
              const Divider(),
              // Bill Row
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total MRP",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                    Obx(
                      () => Text("₹${controller.amount.value}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Coupon Discount",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.green)),
                    Obx(
                      () => Text("₹${controller.couponDiscount.value}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.green)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Delivery Fee",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                    Text("₹199.0",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("GST",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                    Text("₹38.00",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Handling Fee",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                    Text("₹3.0",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Amount to be paid",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Obx(
                      () => Text("₹${controller.finalAmount.value}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSelection() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: []),
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Select Payment Method",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          controller.pay_type =
                              "COD"; // Set payment type to COD
                          selectedButton = "Button1"; // Update selected button
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: selectedButton == "Button1"
                            ? Colors.cyan
                            : Colors
                                .white, // Change background color based on selection
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.cyan),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.money,
                              size: 14,
                              color: selectedButton == "Button1"
                                  ? Colors.white
                                  : Colors
                                      .black), // Change icon color based on selection
                          SizedBox(width: 6),
                          Text(
                            "Cash on Delivery",
                            style: TextStyle(
                              fontSize: 10,
                              color: selectedButton == "Button1"
                                  ? Colors.white
                                  : Colors
                                      .black, // Change text color based on selection
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          controller.pay_type =
                              "ONLINE"; // Set payment type to ONLINE
                          selectedButton = "Button2"; // Update selected button
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: selectedButton == "Button2"
                            ? Colors.cyan
                            : Colors
                                .white, // Change background color based on selection
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.cyan),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.credit_card,
                              size: 14,
                              color: selectedButton == "Button2"
                                  ? Colors.white
                                  : Colors
                                      .black), // Change icon color based on selection
                          SizedBox(width: 6),
                          Text(
                            "Online Payment",
                            style: TextStyle(
                              fontSize: 10,
                              color: selectedButton == "Button2"
                                  ? Colors.white
                                  : Colors
                                      .black, // Change text color based on selection
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return SwipeButton.expand(
      thumb: Icon(
        Icons.double_arrow,
        color: Colors.white,
      ),
      child: Text(
        "Swipe to Checkout",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
      activeThumbColor: Colors.cyan.shade700,
      activeTrackColor: Colors.cyan.shade600,
      onSwipe: () {
        if (controller.pay_type == "COD") {
          controller.confirmOrder();
        } else {
          openCheckout(); // Call openCheckout for online payment
        }
      },
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("● ",
                    style: TextStyle(fontSize: 18, color: Color(0xFF5B6063))),
                Expanded(
                  child: Text(
                    "A licensed pharmacy would be delivering your order based on product availability and fastest delivery.",
                    style:
                        const TextStyle(fontSize: 18, color: Color(0xFF5B6063)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("● ",
                    style: TextStyle(fontSize: 18, color: Color(0xFF5B6063))),
                Expanded(
                  child: Text(
                    "Prices are indicative and may change after billing.",
                    style:
                        const TextStyle(fontSize: 18, color: Color(0xFF5B6063)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("● ",
                    style: TextStyle(fontSize: 18, color: Color(0xFF5B6063))),
                Expanded(
                  child: Text(
                    "LifeMedix is a technology platform to connect sellers and buyers and is not involved in sales of any product. Offer for sale on the products and services are provided/sold by the sellers only.",
                    style:
                        const TextStyle(fontSize: 18, color: Color(0xFF5B6063)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (i) {
      return;
    }
    _razorpay.clear();
    controller.confirmOrder();
    Get.snackbar(
      "Payment Successful",
      "Your Order Has Been Booked",
    );

    print("Payment Successful: ${response.paymentId}");
    i = true;
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed: ${response.message}");
    Get.snackbar(
      "Payment Failed",
      "Please retry payment",
    );
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_USsL9T0ExvziHd',
      'amount': controller.finalAmount.value * 100,
      'name': 'Life Medix',
      'prefill': {
        'contact': '9999999999',
        'email': 'test@razorpay.com',
      },
      'theme': {'color': '#000000'},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }
}
