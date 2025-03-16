import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../controller/product_controller.dart';
import '../generated/const_data.dart';
import 'product_detail_page.dart'; // Import the ProductDetailPage (adjust the path as needed)

class TopProductsPage extends StatelessWidget {
  final ProductController productController =
      Get.find<ProductController>(); // Assuming you're using GetX

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Top Selling Products",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.cyan.shade200,
        elevation: 4,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan.shade200, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Obx(() {
          if (productController.isTopsLoaded.value) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else {
            return ListView.separated(
              itemCount: productController.productModel!.data.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: 20), // Increased spacing between items
              itemBuilder: (context, index) {
                final product = productController.productModel!.data[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to ProductDetailPage with the selected product
                    Get.to(ProductDetailPage(product: product));
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: ConstantData.SERVER_ADDRESS_IMAGE +
                                    product.subImg,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.white,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    size: 40,
                                    color: Colors.red),
                              ),
                            ),
                            SizedBox(
                                width: 16), // Spacing between image and text
                            // Product Text Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.subName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "\₹${product.subPrice}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.cyan.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
