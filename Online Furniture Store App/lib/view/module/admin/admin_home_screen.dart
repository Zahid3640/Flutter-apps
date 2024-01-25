import 'package:flutter/material.dart';

import '../../../constant/app_color/app_color.dart';
import '../../../firebase/cloud_firestore.dart';
import 'admin_allUser_screen.dart';
import 'pos/admin_pos_screen.dart';
import 'admin_profile.dart';


class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List<Widget> navigationScreen = [const admin_allUser_screen(), const AdminPOSScreen(),const AdminProfileScreen()];
  int screenIndex = 1;

  @override
  initState() {
    super.initState();
  }
  Future<void> registerAdmin() async {
    await CloudFirestoreServices().addAdmin();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationScreen[screenIndex],
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 20,
          selectedFontSize: 15,
          selectedIconTheme:
          const IconThemeData(color: AppColors.primaryWhiteColor, size: 30),
          selectedItemColor: AppColors.primaryWhiteColor,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          backgroundColor: AppColors.tealColor,
          unselectedIconTheme: const IconThemeData(
            color: AppColors.orangeColor,
          ),
          unselectedItemColor: AppColors.orangeColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.replay_circle_filled),
              label: 'Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.remove_from_queue),
              label: 'POS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: screenIndex,
          onTap: onItemTapped,
        )
    );
  }
  void onItemTapped(int index) {
    setState(() {
      screenIndex = index;
    });
  }
}
