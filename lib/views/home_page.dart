import 'package:carousel_slider_x/carousel_slider_x.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:life_medix_demo/views/cart_screen.dart';
import 'package:life_medix_demo/views/labtest_page.dart';
import 'package:life_medix_demo/views/product_detail_page.dart';
import 'package:life_medix_demo/views/see_all_categories.dart';
import 'package:life_medix_demo/views/see_all_tops_product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:life_medix_demo/controller/banner_controller.dart';
import 'package:life_medix_demo/controller/category_controller.dart';
import 'package:life_medix_demo/views/product_screen.dart';
import 'package:life_medix_demo/generated/const_data.dart';
import 'package:life_medix_demo/controller/product_controller.dart'; // Add import for product controller

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(BannerController());
  final categoryController = Get.put(CategoryController());
  final productController =
      Get.put(ProductController()); // Instantiate ProductController
  String username = "";

  @override
  void initState() {
    super.initState();
    _loadUsername();
    // Replace with actual user id
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(ConstantData.KEY_NAME_SP) ?? "User ";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/images/set_logoo.png', // Replace with the actual path of your image
              height: 80,
              width: 80,
            ),
            SizedBox(width: 10),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.cyan.shade600),
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.cyan.shade600),
            onPressed: () {
              Get.to(CartScreen());
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isloaded.value &&
            categoryController.isloaded.value &&
            productController.isTopsLoaded.value) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Welcome  $username healthier life with LifeMedix",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "RobotoMono",
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Get.to()
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/book_medicine.jpg",
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(LabtestPage());
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/book_labtest.jpg',
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                      ),
                      items: controller.bannerModel!.data.map(
                        (e) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                ConstantData.SERVER_ADDRESS_IMAGE + e.bImg,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.broken_image, size: 60),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          controller.bannerModel!.data.length,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(AllCategoriesScreen());
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            color: Colors.cyan.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GridView.builder(
                  padding: EdgeInsets.all(16),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: categoryController.categorymodel!.data.length,
                  itemBuilder: (context, index) {
                    final category =
                        categoryController.categorymodel!.data[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ProductListScreen(
                              categoryId: category.catId,
                              catName: category.catName,
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(ConstantData.SERVER_ADDRESS_IMAGE +
                                category.catImg),
                            Text(category.catName),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // Top Selling Products Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Selling Products",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the "See All" page for Top Products
                          Get.to(TopProductsPage());
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.cyan.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  if (productController.isTopsLoaded.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (productController.productModel == null ||
                        productController.productModel!.data == null) {
                      return Center(child: Text("No products available."));
                    }

                    return Container(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 products per row
                          crossAxisSpacing: 7.0, // Spacing between columns
                          mainAxisSpacing: 7.0, // Spacing between rows
                          childAspectRatio:
                              0.76, // Adjusted aspect ratio for better design
                        ),
                        itemCount: 4,
                        // itemCount: productController.productModel!.data.length,
                        itemBuilder: (context, index) {
                          final product =
                              productController.productModel!.data[index];

                          return GestureDetector(
                            onTap: () {
                              // Navigate to ProductDetailPage with the selected product
                              Get.to(ProductDetailPage(product: product));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(
                                    color: Colors
                                        .grey.shade300, // Gray border color
                                    width: 1, // Border width
                                  ),
                                ),
                                elevation: 0, // Removed shadow
                                color: Colors.white,
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment
                                        .center, // Ensuring center alignment
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          ConstantData.SERVER_ADDRESS_IMAGE +
                                              product.subImg,
                                          width: double.infinity,
                                          height:
                                              120, // Adjusted height for proper aspect ratio
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Icon(Icons.error,
                                                      color: Colors.red),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Center(
                                        child: Text(
                                          product.subName,
                                          style: TextStyle(
                                            fontSize:
                                                16, // Increased font size for better readability
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow
                                              .ellipsis, // Handles overflow in title
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Center(
                                        child: Text(
                                          "\₹${product.subPrice}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.cyan.shade600,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),

                Container(
                  height: 60,
                  width: 60,
                  color: Colors.white,
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
