import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/order_history_controller.dart';
import '../model/cart_model.dart';
import 'package:life_medix_demo/generated/const_data.dart';

class OrderHistory extends StatelessWidget {
  final OrderHistoryController controller = Get.put(OrderHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
        backgroundColor: Colors.cyan, // Modern cyan theme
      ),
      body: Obx(() {
        if (!controller.isLoaded.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.cartModel == null ||
            controller.cartModel!.order.isEmpty) {
          return Center(
              child: Text("No orders found", style: TextStyle(fontSize: 18)));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchOrderHistory(); // Refresh the order history
          },
          child: ListView.builder(
            itemCount: controller.cartModel!.order.length,
            itemBuilder: (context, index) {
              final order = controller.cartModel!.order[index];
              return OrderTrackingCard(order: order);
            },
          ),
        );
      }),
    );
  }
}

class OrderTrackingCard extends StatelessWidget {
  final Order order;

  OrderTrackingCard({required this.order});

  String getStatusText(String status) {
    switch (status) {
      case "1":
        return "Order Placed";
      case "2":
        return "Processing";
      case "3":
        return "Shipped";
      case "4":
        return "Delivered";
      default:
        return "Pending";
    }
  }

  int getStatusIndex(String status) {
    return int.tryParse(status) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    int currentStep = getStatusIndex(order.status);

    return Card(
      margin: EdgeInsets.all(12),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              ConstantData.SERVER_ADDRESS_IMAGE + order.ppic,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order ID: ${order.id}",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text("Product: ${order.pname}",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                SizedBox(height: 5),
                Text("Amount: ₹${order.totalAmount}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
                SizedBox(height: 5),
                Text("Quantity: ${order.quantity}",
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 5),
                Text("Date: ${order.date}",
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                SizedBox(height: 10),
                Stepper(
                  physics: NeverScrollableScrollPhysics(),
                  currentStep: currentStep,
                  controlsBuilder: (context, details) => SizedBox(),
                  steps: [
                    Step(
                      title: Text("Order Placed"),
                      content: SizedBox(),
                      isActive: currentStep >= 0,
                      state: currentStep >= 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: Text("Processing"),
                      content: SizedBox(),
                      isActive: currentStep >= 1,
                      state: currentStep >= 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: Text("Shipped"),
                      content: SizedBox(),
                      isActive: currentStep >= 2,
                      state: currentStep >= 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: Text("Delivered"),
                      content: SizedBox(),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Current Status: ${getStatusText(order.status)}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
