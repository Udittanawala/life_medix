import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_medix_demo/controller/labtest_controller.dart';
import 'package:life_medix_demo/generated/const_data.dart';
import 'package:life_medix_demo/views/labtestPackages_page.dart';

class LabtestPage extends StatelessWidget {
  final labtestcontroller = Get.put(LabtestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Lab Tests')),
        backgroundColor: Colors.cyan.shade100,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Obx(() {
          if (labtestcontroller.isloaded.value) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: labtestcontroller.labtestModel?.data.length ?? 0,
              itemBuilder: (context, index) {
                var test = labtestcontroller.labtestModel!.data[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to LabTestPackagesPage with the test_id
                    Get.to(LabTestPackagesPage(testId: test.testId.toString()));
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade100,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            ConstantData.SERVER_ADDRESS_IMAGE + test.testImg,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        test.testDisease,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
