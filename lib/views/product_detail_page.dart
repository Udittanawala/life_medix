import 'package:carousel_slider_x/carousel_slider_x.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:life_medix_demo/controller/cart_controller.dart';
import 'package:life_medix_demo/views/cart_screen.dart';
import '../controller/product_controller.dart'; // Import CartController
import '../generated/const_data.dart';
import '../model/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  Product product;
  final productController = Get.put(ProductController());
  final cartController = Get.put(CartController());
  final RxBool isButtonVisible = false.obs;

  ProductDetailPage({required this.product}) {
    productController.getRelatedProduct(
        sub_id: product.subId, cat_id: product.catId);
  }

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [
      "${ConstantData.SERVER_ADDRESS_IMAGE}${product.subImg}",
      "${ConstantData.SERVER_ADDRESS_IMAGE}${product.subImg1}",
      "${ConstantData.SERVER_ADDRESS_IMAGE}${product.subImg2}",
      //"${ConstantData.SERVER_ADDRESS_IMAGE}${product.subImg3}",
    ];
    // if (product.subImg3 == SubImg3.IMAGES) {
    //   imageUrls.add("${ConstantData.SERVER_ADDRESS_IMAGE}${product.subImg3}");
    // }

    double mrp = double.tryParse(product.subPrice) ?? 0.0;
    double discountPercentage = 5.0;
    double discountedPrice = mrp - (mrp * (discountPercentage / 100));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan[100],
        title: Text("Product Details",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                  ),
                  items: imageUrls.map((url) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(url, width: double.infinity),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 4,
                  color: Colors.cyan[50],
                  shadowColor: Colors.cyan.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.subName,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          product.subDiscription,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        Text("Inclusive of all taxes",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.cyan[600],
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "MRP: ₹$mrp",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[500],
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(
                              "₹$discountedPrice",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700]),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Obx(() {
                          if (isButtonVisible.value) {
                            return Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Get.to(CartScreen());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                  ),
                                  child: const Text(
                                    "View Cart",
                                    style: TextStyle(
                                      color: Colors.cyan,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          } else {
                            return ElevatedButton(
                              onPressed: () {
                                isButtonVisible.value = true;
                                cartController.addToCart(product: product);
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: Colors.cyan.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text(
                                "Add to Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }
                        })
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Related Products",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Obx(
                () {
                  if (productController.isRelatedLoad.value) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else {
                    return Container(
                      color: Colors.white,
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            productController.relatedProductModel!.data.length,
                        itemBuilder: (context, index) {
                          final product =
                              productController.productModel!.data[index];
                          final relatedProduct = productController
                              .relatedProductModel!.data[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => ProductDetailPage(product: product));
                            },
                            child: Container(
                              width: 160,
                              margin: EdgeInsets.only(right: 10),
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 2,
                                child: Column(
                                  children: [
                                    Image.network(
                                      "${ConstantData.SERVER_ADDRESS_IMAGE}${relatedProduct.subImg}",
                                      height: 100,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        relatedProduct.subBrend,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
