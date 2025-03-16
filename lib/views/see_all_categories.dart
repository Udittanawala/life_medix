import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_medix_demo/controller/category_controller.dart';
import 'package:life_medix_demo/generated/const_data.dart';
import 'package:life_medix_demo/views/product_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class AllCategoriesScreen extends StatelessWidget {
  final CategoryController categoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Categories",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
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
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
        child: Obx(() {
          if (categoryController.isloaded.value) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else {
            return ListView.separated(
              itemCount: categoryController.categorymodel!.data.length,
              separatorBuilder: (context, index) => SizedBox(
                  height: 40), // Increased the height for better spacing
              itemBuilder: (context, index) {
                final category = categoryController.categorymodel!.data[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ProductListScreen(
                          categoryId: category.catId,
                          catName: category.catName,
                        ));
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 16),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 90), // Space for image overlap
                            Expanded(
                              child: Text(
                                category.catName,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                size: 20, color: Colors.black),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: -20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: ConstantData.SERVER_ADDRESS_IMAGE +
                                category.catImg,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: 80,
                                height: 80,
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error, size: 40, color: Colors.red),
                          ),
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
