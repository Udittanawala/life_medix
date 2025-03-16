// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:life_medix_demo/controller/search_controller.dart';
// import 'package:life_medix_demo/views/product_detail_page.dart'; // Import the product detail page
//
// class SearchResultsPage extends StatelessWidget {
//   final String initialSearchText;
//
//   SearchResultsPage({required this.initialSearchText});
//
//   final SearchController searchController = Get.find<SearchController>();
//   final TextEditingController searchTextController = TextEditingController();
//
//   @override
//   void initState() {
//     // Set the initial text in the search field
//     searchTextController.text = initialSearchText;
//     // Perform the initial search
//     searchController.search(initialSearchText);
//   }
//
//   void _performSearch() {
//     if (searchTextController.text.isNotEmpty) {
//       searchController.search(searchTextController.text);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Initialize the search text controller
//     searchTextController.text = initialSearchText;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Results'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: _performSearch,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: searchTextController,
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 border: OutlineInputBorder(),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: _performSearch,
//                 ),
//               ),
//               onSubmitted: (value) => _performSearch(),
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               if (searchController.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (searchController.searchResults.isEmpty) {
//                 return Center(child: Text('No results found.'));
//               } else {
//                 return ListView.builder(
//                   itemCount: searchController.searchResults.length,
//                   itemBuilder: (context, index) {
//                     final result = searchController.searchResults[index];
//                     return ListTile(
//                       title: Text(
//                           result.subName), // Adjust based on your data model
//                       subtitle: Text(result.subPrice
//                           .toString()), // Adjust based on your data model
//                       onTap: () {
//                         // Navigate to the detail page for the selected result
//                         Get.to(ProductDetailPage(product: result));
//                       },
//                     );
//                   },
//                 );
//               }
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
