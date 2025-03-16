import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_medix_demo/controller/lebtestfrompackages_controller.dart';

class LabTestPackagesPage extends StatelessWidget {
  final String testId; // The selected test's ID

  LabTestPackagesPage({required this.testId});

  // Initialize controllers
  final LabtestPackageController labtestPackageController =
      Get.put(LabtestPackageController());

  @override
  Widget build(BuildContext context) {
    // Fetch lab test packages when the page is loaded
    labtestPackageController.getlabtestPackages(test_id: testId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Lab Test Packages'),
        backgroundColor: Colors.cyan.shade100, // Cyan color
        elevation: 3,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan.shade50, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Show loading indicator while data is being fetched
                  Obx(() {
                    if (labtestPackageController.isLoaded.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    // Display lab test packages
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: labtestPackageController
                              .labtestPackageModel?.data.length ??
                          0,
                      itemBuilder: (context, index) {
                        var package = labtestPackageController
                            .labtestPackageModel!.data[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    package.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    package.includes,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "₹${package.price}",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        "₹500", // Original price should be dynamic
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        "60% OFF", // Discount percentage should be dynamic
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  ElevatedButton(
                                    onPressed: () {
                                      _showBookingBottomSheet(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.cyan.shade600,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Book Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 1.5,
                                    height: 20,
                                  ),
                                  Text(
                                    "Reports in 24 Hrs",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to show the bottom sheet for booking with validation
  void _showBookingBottomSheet(BuildContext context) {
    final TextEditingController address1Controller = TextEditingController();
    final TextEditingController address2Controller = TextEditingController();
    final TextEditingController pincodeController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title for the bottom sheet
                Text(
                  'Confirm Booking',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan.shade600,
                  ),
                ),
                const SizedBox(height: 20),
                // Address fields and validation
                TextFormField(
                  controller: address1Controller,
                  decoration: InputDecoration(
                    labelText: 'Address 1',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Address 1';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: address2Controller,
                  decoration: InputDecoration(
                    labelText: 'Address 2',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Address 2';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: pincodeController,
                  decoration: InputDecoration(
                    labelText: 'Pincode',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Pincode';
                    } else if (value.length != 6) {
                      return 'Pincode must be 6 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Proceed with booking
                      Navigator.pop(context); // Close the BottomSheet
                      // Add booking action here
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan.shade600,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
