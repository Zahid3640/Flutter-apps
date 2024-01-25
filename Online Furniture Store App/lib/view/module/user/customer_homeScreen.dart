import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/view/module/user/shopping_screen.dart';

import '../../../constant/app_color/app_color.dart';
import '../../../controller/authentication_helper.dart';
import '../../../controller/data_controller.dart';
import 'customer_order_screen.dart';
import 'customer_profile.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  List<Widget> navigationScreen = [ CustomerOrderScreen(), const ShoppingScreen(),const CustomerProfileScreen()];
  int screenIndex = 1;
  late DataController _dataController;
  @override
  void initState() {
    try {
      _dataController = Get.find();
    } catch (exception) {
      _dataController = Get.put(DataController());
    }
    _dataController.readCurrentUserOrders(AuthenticationHelper().user.uid);
    _dataController.readUserInfo();
    super.initState();
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
              icon: Icon(Icons.store),
              label: 'Shopping',
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
