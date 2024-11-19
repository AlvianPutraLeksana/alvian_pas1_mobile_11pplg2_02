import 'package:screens/Football/football_view.dart';
import 'package:screens/Favorite/favorite_view.dart';
import 'package:screens/LoginApi/apilogin_view.dart';

import 'package:screens/Profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0; // State untuk halaman saat ini

  final List<Widget> _screens = [

    FootballView(),
    FavoriteView(),
    ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      // Menampilkan halaman sesuai index saat ini
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: MotionTabBar(
          initialSelectedTab: "Football",
          useSafeArea: true,
          labels: const ["Football", "Favorite", "Profile"],
          icons: const [
            Icons.movie_outlined, 
            Icons.favorite_border, 
            Icons.person_outline
          ],
          tabSize: 50,
          tabBarHeight: 55,
          textStyle: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          tabIconColor: Colors.grey[600],
          tabIconSize: 28.0,
          tabIconSelectedSize: 26.0,
          tabSelectedColor: Colors.blue[800],
          tabIconSelectedColor: Colors.white,
          onTabItemSelected: (index) {
            setState(() {
              _currentIndex = index; // Update halaman saat ini
            });
          },
        ),
      ),
    );
  }
}
