import 'dart:async';

import 'package:bedmyway/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:bedmyway/repositories/components/page_view.dart';

class Onboarding1 extends StatefulWidget {
  const Onboarding1({Key? key}) : super(key: key);

  @override
  _Onboarding1State createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  late Future<void> _precacheImagesFuture;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      OnboardingPage(
        title: 'BedMyWay',
        description:
            'Explore a personalized hotel booking experience with BedMyWay.',
        imagePath: 'assets/images/tholaal-mohamed-8sKTHeGgrUM-unsplash.jpg',
        skipText: 'Skip >>',
        previousText: '',
        onNextPressed: () {
          _nextPage();
        },
        onPreviousPressed: () {
          _previousPage();
        },
        beforetitle: 'Welcome to',
      ),
      OnboardingPage(
        title: 'Discover Travel Hotels',
        description: 'Find the perfect travel accommodations anywhere you go.',
        imagePath: 'assets/images/kellen-riggin-w--s4GojseY-unsplash.jpg',
        skipText: 'Skip >>',
        previousText: '<< Prev',
        onNextPressed: () {
          _nextPage();
        },
        onPreviousPressed: () {
          _previousPage();
        },
        beforetitle: '',
      ),
      OnboardingPage(
        title: 'Easily Book Hotels Anywhere',
        description:
            'Book hotels hassle-free with our convenient booking system.',
        imagePath: 'assets/images/cardmapr-nl-hTUZW7E7krg-unsplash.jpg',
        skipText: 'Finish',
        previousText: '<< Prev',
        onNextPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const Logingpage(),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder: (context, animation1, animation2, child) {
                return FadeTransition(
                  opacity: animation1,
                  child: child,
                );
              },
            ),
          );
        },
        onPreviousPressed: () {
          _previousPage();
        },
        beforetitle: '',
      ),
    ];

    _precacheImagesFuture = _precacheImages(); // Initialize the future
  }

  Future<void> _precacheImages() async {
    // Pre-cache all images
    for (var page in _pages) {
      if (page is OnboardingPage) {
        await precacheImage(AssetImage(page.imagePath), context);
      }
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _precacheImagesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Once the images are precached, return the PageView
          return Scaffold(
            body: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: _pages,
                ),
                Positioned(
                  bottom: 8.0,
                  left: 0.0,
                  right: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        height: 10.0,
                        width: _currentPage == index ? 25.0 : 10.0,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? const Color.fromARGB(255, 255, 5, 5)
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        } else {
          // While images are precaching, show a loading indicator
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
