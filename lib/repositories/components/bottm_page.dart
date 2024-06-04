// ignore_for_file: prefer_const_constructors, deprecated_member_use, library_private_types_in_public_api

import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/view/bottmscrrens/home_page.dart';
import 'package:bedmyway/view/bottmscrrens/mesg_page.dart';
import 'package:bedmyway/view/bottmscrrens/my_booking.dart';
import 'package:bedmyway/view/bottmscrrens/search_page.dart';
import 'package:flutter/material.dart';
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
    Homepage(),
    Mybooking(),
    Searchpage(),
    Messegepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _widgetOptions.elementAt(_selectedIndex),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
              child: Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(77, 180, 180, 180),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: GNav(
                    gap: 8,
                    activeColor: Colors.white,
                    iconSize: 24,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    duration: const Duration(milliseconds: 800),
                    tabBackgroundColor: Color.fromARGB(195, 230, 12, 12),
                    color: Colors.black,
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
                        icon: FontAwesomeIcons.search,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
