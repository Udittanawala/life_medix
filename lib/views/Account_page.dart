import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_medix_demo/controller/editprofile_controller.dart';
import 'package:life_medix_demo/generated/pref_manager.dart';
import 'package:life_medix_demo/views/edit_profile_screen.dart';
import 'package:life_medix_demo/views/legal_page.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  File? _selectedImage;
  final EditProfileController _controller = Get.put(EditProfileController());
  bool isFAQExpanded = false;

  final List<Map<String, String>> faqData = [
    {
      "question": "What is LifeMedix?",
      "answer":
          "LifeMedix is an online medicine and healthcare product delivery platform. It allows users to browse a wide range of medicines, wellness products, and health essentials. Users can place orders, upload prescriptions, and get doorstep delivery quickly and conveniently."
    },
    {
      "question": "How can I register on LifeMedix?",
      "answer":
          "To register, open the LifeMedix app and click on the Sign Up button. Enter your basic details such as name, email, phone number, and password. You may also need to verify your phone number using an OTP sent via SMS. Once verified, your account will be created, and you can start using the app"
    },
    {
      "question": "How can I reset my password?",
      "answer":
          "If you forget your password go to the login screen and click on the Forgot Password link. Enter your registered email or phone number, and we will send you a password reset link or OTP. Follow the instructions to set a new password and regain access to your account."
    },
    {
      "question": "How do I browse and search for products?",
      "answer":
          "You can browse products using categories such as Medicines, Healthcare, Personal Care, and more. Additionally, you can use the search bar at the top of the app to type the name of the medicine or product you're looking for. Filters are also available to refine your search by brand, price, and availability."
    },
    {
      "question": "How do I add items to my cart?",
      "answer":
          "Once you find the product you want, tap on it to view details. Click the Add to Cart button, and the item will be added to your cart. You can continue shopping and add more items or proceed to checkout when you're ready."
    },
    {
      "question": "What payment methods are available?",
      "answer":
          "LifeMedix supports multiple payment options, including Credit/Debit Cards, UPI, Net Banking, and Wallets. We also provide the option for Cash on Delivery (COD) in selected locations. All transactions are secured with encryption to ensure safe payments."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade100,
        title: Text("Account",
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      body: Container(
        padding: EdgeInsets.all(17),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: 20),
            _buildProfileSection(),
            SizedBox(height: 25),
            _buildAccountOptions(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              backgroundImage: _selectedImage != null
                  ? FileImage(_selectedImage!)
                  : AssetImage("assets/images/default_avatar.png")
                      as ImageProvider,
            ),
            GestureDetector(
              onTap: _pickImageFromGallery,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Icon(Icons.camera_alt, color: Colors.cyan.shade700),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Text("Welcome, Username",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade600)),
      ],
    );
  }

  Widget _buildAccountOptions() {
    return Column(
      children: [
        buildOptionCard("Edit Profile", Icons.edit, isEditProfile: true),
        buildOptionCard("Your Order", Icons.shopping_cart),
        buildOptionCard("Saved Letter", Icons.bookmark),
        buildOptionCard("About Us", Icons.info),
        buildOptionCard("Need Help", Icons.help),
        buildOptionCard("FAQ", Icons.question_answer, isFAQ: true),
        if (isFAQExpanded) _buildFAQSection(),
        buildOptionCard("Legal", Icons.gavel, isLegal: true),
        buildOptionCard("Log Out", Icons.logout, isLogout: true),
      ],
    );
  }

  Widget buildOptionCard(String title, IconData icon,
      {bool isEditProfile = false,
      bool isLogout = false,
      bool isLegal = false,
      bool isFAQ = false}) {
    return GestureDetector(
      onTap: () {
        if (isEditProfile) {
          Get.to(() => EditProfile());
        } else if (isLogout) {
          PrefManager manager = PrefManager();
          manager.logoutUser();
        } else if (isLegal) {
          Get.to(() => LegalPage());
        } else if (isFAQ) {
          setState(() {
            isFAQExpanded = !isFAQExpanded;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.cyan.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.cyan.shade700, size: 26),
            SizedBox(width: 15),
            Expanded(
              child: Text(title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            ),
            Icon(
              isFAQ
                  ? (isFAQExpanded ? Icons.expand_less : Icons.expand_more)
                  : Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey.shade700,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      children: faqData.map((faq) {
        return ExpansionTile(
          title: Text(faq['question']!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(faq['answer']!,
                  style: TextStyle(color: Colors.grey[700])),
            )
          ],
        );
      }).toList(),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      setState(() {
        _selectedImage = File(returnImage.path);
      });
    }
  }
}
