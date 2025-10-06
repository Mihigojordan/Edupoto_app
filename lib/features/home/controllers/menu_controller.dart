import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/hoso_home_screen.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/hoso_services/hoso_services.dart';
import 'package:hosomobile/features/home/screens/upgrades/no_connection/no_connection.dart';
import 'package:hosomobile/features/setting/screens/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/shop/screen/shop_screen.dart';

class MenuItemController extends GetxController implements GetxService{
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;


  final List<Widget> screen = [
   const HosoHomeScreen(),
  //  const HomeScreen(),
<<<<<<< HEAD
 const ShoppingScreen(),
    // const MzaziScreen(isShop: false,isNavigation:1),
=======
// const ShoppingScreen(),
 const MzaziScreen(isShop: false,isNavigation:1),
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
     const NoConnection(),
    const ProfileScreen()

  ];

  void resetNavBarTabIndex(){
    _currentTabIndex = 0;
  }

  void selectHomePage({bool isUpdate = true}) {
    _currentTabIndex = 0;
    if(isUpdate) {
      update();
    }
  }

  void selectHistoryPage({bool isUpdate=true}) {
    _currentTabIndex = 1;
    if(isUpdate){
 update();     
    }
    
  }

  void selectNotificationPage() {
    _currentTabIndex = 2;
    update();
  }

  void selectProfilePage() {
    _currentTabIndex = 3;
    update();
  }
}
