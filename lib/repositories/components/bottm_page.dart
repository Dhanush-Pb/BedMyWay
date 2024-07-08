// ignore_for_file: library_private_types_in_public_api

import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:bedmyway/view/bottmscrrens/home_page.dart';
import 'package:bedmyway/view/bottmscrrens/mesg_page.dart';
import 'package:bedmyway/view/bottmscrrens/my_booking.dart';
import 'package:bedmyway/view/bottmscrrens/search_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Homepage(),
    const Mybooking(),
    const Searchpage(),
    const Messegepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Appcolor.white,
          boxShadow: [
            BoxShadow(
              color: Appcolor.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: GNav(
          gap: 8,
          activeColor: Appcolor.white,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          duration: const Duration(milliseconds: 500),
          tabBackgroundColor: Appcolor.bottmicon,
          color: Appcolor.black,
          tabs: const [
            GButton(
              icon: FontAwesomeIcons.house,
              iconSize: 18,
              text: 'Home',
            ),
            GButton(
              icon: FontAwesomeIcons.ticket,
              iconSize: 22,
              text: 'Booked',
            ),
            GButton(
              icon: FontAwesomeIcons.magnifyingGlass,
              iconSize: 19,
              text: 'Search',
            ),
            GButton(
              icon: FontAwesomeIcons.facebookMessenger,
              text: 'Message',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
