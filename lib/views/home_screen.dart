import 'package:flutter/material.dart';
import 'package:life_medix_demo/views/Account_page.dart';
import 'package:life_medix_demo/views/home_page.dart';
import 'package:life_medix_demo/views/labtest_page.dart';
import 'package:life_medix_demo/views/offers_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    LabtestPage(),
    OffersPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     blurRadius: 12,
          //     spreadRadius: 2,
          //   ),
          // ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: GNav(
            rippleColor: Colors.cyan.shade100,
            hoverColor: Colors.cyan.shade200,
            gap: 8,
            backgroundColor: Colors.white,
            color: Colors.cyan.shade200,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.cyan.shade600,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: [
              GButton(
                icon: FontAwesomeIcons.house,
                text: 'Home',
              ),
              GButton(
                icon: FontAwesomeIcons.flask,
                text: 'Lab-Test',
              ),
              GButton(
                icon: FontAwesomeIcons.tags,
                text: 'Offers',
              ),
              GButton(
                icon: FontAwesomeIcons.userCircle,
                text: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
