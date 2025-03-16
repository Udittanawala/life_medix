import 'package:flutter/material.dart';

class LegalPage extends StatefulWidget {
  const LegalPage({super.key});

  @override
  State<LegalPage> createState() => _LegalPageState();
}

class _LegalPageState extends State<LegalPage> {
  bool _isTermsExpanded = false;
  bool _isPrivacyExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          size: 28, color: Colors.cyan),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Legal",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildExpandableSection(
                title: "Terms and Conditions",
                isExpanded: _isTermsExpanded,
                onTap: () {
                  setState(() {
                    _isTermsExpanded = !_isTermsExpanded;
                  });
                },
                content: _termsAndConditionsContent(),
              ),
              SizedBox(
                height: 20,
              ),
              _buildExpandableSection(
                title: "Privacy Policy",
                isExpanded: _isPrivacyExpanded,
                onTap: () {
                  setState(() {
                    _isPrivacyExpanded = !_isPrivacyExpanded;
                  });
                },
                content: _privacyPolicyContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget content,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyan.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.policy, size: 30, color: Colors.cyan[700]),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 25,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: content,
          ),
      ],
    );
  }

  Widget _termsAndConditionsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Welcome to LifeMedix!"),
        _buildSectionText(
          "Before using our application, please take a moment to review the following terms and conditions carefully. "
          "By accessing or using LifeMedix, you agree to abide by these terms and conditions.",
        ),
        _buildSectionTitle("Acceptance of Terms:"),
        _buildSectionText(
          "By accessing or using LifeMedix, you agree to be bound by these terms and conditions. If you do not agree to these terms, please refrain from using the application.",
        ),
        _buildSectionTitle("User Eligibility:"),
        _buildSectionText(
          "LifeMedix is intended for individuals aged 18 and older. By using the application, you confirm that you meet this requirement.",
        ),
        _buildSectionTitle("Account Registration:"),
        _buildSectionText(
          "To access certain features, you may be required to create an account. You are responsible for maintaining the confidentiality of your account credentials.",
        ),
        _buildSectionTitle("Medical Disclaimer:"),
        _buildSectionText(
          "LifeMedix does not provide medical advice. Always consult a qualified healthcare professional before using medications.",
        ),
        _buildSectionTitle("Ordering and Purchasing:"),
        _buildSectionText(
          "By placing an order, you confirm the accuracy of the information provided. Orders are subject to availability and approval.",
        ),
        _buildSectionTitle("Payment and Pricing:"),
        _buildSectionText(
          "Payments must be made using the available payment methods. Prices are subject to change without notice.",
        ),
        _buildSectionTitle("Delivery and Returns:"),
        _buildSectionText(
          "Delivery times vary. Please review our shipping and returns policy for further details.",
        ),
        _buildSectionTitle("Intellectual Property:"),
        _buildSectionText(
          "All content on LifeMedix is the property of LifeMedix or its licensors and is protected by copyright laws.",
        ),
        _buildSectionTitle("User Conduct:"),
        _buildSectionText(
          "Users must comply with all applicable laws. Prohibited activities include transmitting unlawful or harmful content.",
        ),
        _buildSectionTitle("Contact Us:"),
        _buildSectionText(
          "If you have any questions about these terms, please contact our support team.",
        ),
      ],
    );
  }

  Widget _privacyPolicyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Privacy Policy"),
        _buildSectionText(
            "Your privacy is important to us. We collect only necessary data to improve your experience."),
        _buildSectionTitle("Data Collection"),
        _buildSectionText(
            "We collect personal information such as name, email, and order details to enhance our service."),
        _buildSectionTitle("Data Usage"),
        _buildSectionText(
            "Your data is used to process orders, improve our services, and ensure security."),
        _buildSectionTitle("Third-Party Sharing"),
        _buildSectionText(
            "We do not sell or share your data with third parties except as required by law."),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSectionText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, color: Colors.black54),
    );
  }
}
// import 'package:flutter/material.dart';
//
// class LegalPage extends StatefulWidget {
//   const LegalPage({super.key});
//
//   @override
//   State<LegalPage> createState() => _LegalPageState();
// }
//
// class _LegalPageState extends State<LegalPage> {
//   bool _isExpanded = false; // State to manage expansion
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.cyan[50],
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Back Button and Title
//               Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back,
//                           size: 28, color: Colors.cyan),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                     const SizedBox(width: 10),
//                     const Text(
//                       "Legal",
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.cyan,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 30),
//
//               // Expandable Terms and Conditions
//               _buildExpandableTerms(),
//
//               // Other Legal Options
//               _buildLegalOption(
//                 icon: Icons.privacy_tip,
//                 text: "Privacy Policy",
//                 onTap: () {},
//               ),
//
//               _buildLegalOption(
//                 icon: Icons.support_agent,
//                 text: "Customer Support Policy",
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget for Expandable Terms and Conditions
//   Widget _buildExpandableTerms() {
//     return Column(
//       children: [
//         InkWell(
//           onTap: () {
//             setState(() {
//               _isExpanded = !_isExpanded;
//             });
//           },
//           borderRadius: BorderRadius.circular(15),
//           child: Container(
//             padding: const EdgeInsets.all(15),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.cyan.withOpacity(0.3),
//                   blurRadius: 8,
//                   spreadRadius: 1,
//                   offset: const Offset(2, 3),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.description, size: 30, color: Colors.cyan[700]),
//                 const SizedBox(width: 15),
//                 const Expanded(
//                   child: Text(
//                     "Terms and Conditions",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//                 Icon(
//                   _isExpanded
//                       ? Icons.keyboard_arrow_up
//                       : Icons.keyboard_arrow_down,
//                   size: 25,
//                   color: Colors.grey,
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         // Expandable content
//         if (_isExpanded)
//           Container(
//             margin: const EdgeInsets.only(top: 10),
//             padding: const EdgeInsets.all(15),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   blurRadius: 5,
//                   spreadRadius: 1,
//                   offset: const Offset(2, 2),
//                 ),
//               ],
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildSectionTitle("Welcome to LifeMedix!"),
//                   _buildSectionText(
//                     "Before using our application, please take a moment to review the following terms and conditions carefully. "
//                     "By accessing or using LifeMedix, you agree to abide by these terms and conditions.",
//                   ),
//                   _buildSectionTitle("Acceptance of Terms:"),
//                   _buildSectionText(
//                     "By accessing or using LifeMedix, you agree to be bound by these terms and conditions. If you do not agree to these terms, please refrain from using the application.",
//                   ),
//                   _buildSectionTitle("User Eligibility:"),
//                   _buildSectionText(
//                     "LifeMedix is intended for individuals aged 18 and older. By using the application, you confirm that you meet this requirement.",
//                   ),
//                   _buildSectionTitle("Account Registration:"),
//                   _buildSectionText(
//                     "To access certain features, you may be required to create an account. You are responsible for maintaining the confidentiality of your account credentials.",
//                   ),
//                   _buildSectionTitle("Medical Disclaimer:"),
//                   _buildSectionText(
//                     "LifeMedix does not provide medical advice. Always consult a qualified healthcare professional before using medications.",
//                   ),
//                   _buildSectionTitle("Ordering and Purchasing:"),
//                   _buildSectionText(
//                     "By placing an order, you confirm the accuracy of the information provided. Orders are subject to availability and approval.",
//                   ),
//                   _buildSectionTitle("Payment and Pricing:"),
//                   _buildSectionText(
//                     "Payments must be made using the available payment methods. Prices are subject to change without notice.",
//                   ),
//                   _buildSectionTitle("Delivery and Returns:"),
//                   _buildSectionText(
//                     "Delivery times vary. Please review our shipping and returns policy for further details.",
//                   ),
//                   _buildSectionTitle("Intellectual Property:"),
//                   _buildSectionText(
//                     "All content on LifeMedix is the property of LifeMedix or its licensors and is protected by copyright laws.",
//                   ),
//                   _buildSectionTitle("User Conduct:"),
//                   _buildSectionText(
//                     "Users must comply with all applicable laws. Prohibited activities include transmitting unlawful or harmful content.",
//                   ),
//                   _buildSectionTitle("Contact Us:"),
//                   _buildSectionText(
//                     "If you have any questions about these terms, please contact our support team.",
//                   ),
//                 ],
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//   // Common Widget for Legal Options
//   Widget _buildLegalOption(
//       {required IconData icon,
//       required String text,
//       required VoidCallback onTap}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(15),
//         child: Container(
//           padding: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.cyan.withOpacity(0.3),
//                 blurRadius: 8,
//                 spreadRadius: 1,
//                 offset: const Offset(2, 3),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               Icon(icon, size: 30, color: Colors.cyan[700]),
//               const SizedBox(width: 15),
//               Expanded(
//                 child: Text(
//                   text,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//               const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Helper method for section titles
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 15, bottom: 5),
//       child: Text(
//         title,
//         style: const TextStyle(
//             fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
//       ),
//     );
//   }
//
//   // Helper method for section content
//   Widget _buildSectionText(String text) {
//     return Text(
//       text,
//       style: const TextStyle(fontSize: 15, color: Colors.black54),
//     );
//   }
// }
