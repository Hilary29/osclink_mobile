import 'package:flutter/material.dart';
import 'package:osclink_mobile/2_home/presentation/screens/home_screen.dart';
import 'package:osclink_mobile/4_profile/presentation/screens/profile_screen.dart';
import 'package:osclink_mobile/6_map/presentation/screens/map_screen.dart';
import 'package:osclink_mobile/7_chat/presentation/screens/chat_screen.dart';
import 'bottom_navigation_bar.dart';

class BottomNavigationWrapper extends StatefulWidget {
  final int initialIndex;

  const BottomNavigationWrapper({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<BottomNavigationWrapper> createState() => _BottomNavigationWrapperState();
}

class _BottomNavigationWrapperState extends State<BottomNavigationWrapper> {
  late int _currentIndex;
  late PageController _pageController;

  final List<Widget> _screens = const [
    HomeScreen(),
    ChatScreen(),
    MapScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}