import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/feature/Home/presentation/view/screens/explore_screen.dart';
import 'package:exam_app/feature/Home/presentation/view/screens/profile_screen.dart';
import 'package:exam_app/feature/Home/presentation/view/screens/result_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [ExploreScreen(), 
  ResultScreen(),
   ProfileTab()];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.white,
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: colors.white,
        indicatorColor: colors.blue.withValues(alpha: 0.12),
        elevation: 8,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: colors.grey),
            selectedIcon: Icon(Icons.home, color: colors.blue),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined, color: colors.grey),
            selectedIcon: Icon(Icons.assignment, color: colors.blue),
            label: 'Result',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: colors.grey),
            selectedIcon: Icon(Icons.person, color: colors.blue),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
