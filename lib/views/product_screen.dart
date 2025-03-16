import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_medix_demo/controller/product_controller.dart';
import 'package:life_medix_demo/generated/const_data.dart';
import 'package:life_medix_demo/views/product_detail_page.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryId;
  final String? catName;
  final ProductController controller = Get.put(ProductController());

  ProductListScreen({required this.categoryId, this.catName});

  @override
  Widget build(BuildContext context) {
    controller.getProductFromCatId(cat_id: categoryId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          catName ?? "Products",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade100,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Obx(
          () {
            if (controller.isLoaded.value) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.productModel == null ||
                controller.productModel!.data.isEmpty) {
              return Center(child: Text('No Products Available'));
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: controller.productModel!.data.length,
                  itemBuilder: (context, index) {
                    final product = controller.productModel!.data[index];

                    return Stack(
                      children: [
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          shadowColor: Colors.black26,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                    child: Image.network(
                                      "${ConstantData.SERVER_ADDRESS_IMAGE}${product.subImg}",
                                      width: 95,
                                      height: 95,
                                      errorBuilder:
                                          (context, error, stackTrace) => Icon(
                                        Icons.broken_image,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      product.subBrend,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "₹${product.subPrice}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.cyan.shade600,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          padding:
                                              EdgeInsets.symmetric(vertical: 0),
                                        ),
                                        onPressed: () {
                                          Get.to(() => ProductDetailPage(
                                              product: product));
                                        },
                                        child: Text(
                                          "Buy Now",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Wishlist Button Positioned at Top-Right
                        // Positioned(
                        //   top: 8,
                        //   right: 8,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       product.isWishlisted = !product.isWishlisted;
                        //       controller.productModel.refresh(); // Refresh UI
                        //     },
                        //     child: CircleAvatar(
                        //       backgroundColor: Colors.white,
                        //       radius: 18,
                        //       child: Icon(
                        //         product.isWishlisted ? Icons.favorite : Icons.favorite_border,
                        //         color: product.isWishlisted ? Colors.red : Colors.grey,
                        //         size: 22,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
