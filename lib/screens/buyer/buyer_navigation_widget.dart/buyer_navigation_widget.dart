import 'package:feliz_coin/screens/buyer/screens/branch_screen/branch_screen.dart';
import 'package:feliz_coin/screens/buyer/screens/shop_screen/shop_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../commons/icon_images.dart';
import '../../../commons/text_style_helper.dart';
import '../../../commons/theme_helper.dart';
import '../screens/QR_code_screen/QR_code_screen.dart';
import '../screens/balance_screen/balance_screen.dart';
import '../screens/profile_screen/profile_screen.dart';

class BuyerNavigationWidget extends StatelessWidget {
  final int currentPage;

  const BuyerNavigationWidget({Key? key, this.currentPage = 0})
      : super(key: key);

  List<BottomNavigationBarItem> _generateItemList() {
    var items = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Image.asset(
          IconsImages.shopIcon,
          width: 40.w,
          height: 40.h,
          color: ThemeHelper.white50,
        ),
        activeIcon: Image.asset(
          IconsImages.shopIcon,
          width: 40.w,
          height: 40.h,
          color: ThemeHelper.white,
        ),
        label: 'Каталог',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          IconsImages.balanceIcon,
          width: 40.w,
          height: 40.h,
          color: ThemeHelper.white50,
        ),
        activeIcon: Image.asset(
          IconsImages.balanceIcon,
          width: 40.w,
          height: 40.h,
          color: ThemeHelper.white,
        ),
        label: "Баланс",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          IconsImages.qrCodeIcon,
          width: 40.w,
          height: 40.h,
          color: ThemeHelper.white50,
        ),
        activeIcon: Image.asset(
          IconsImages.qrCodeIcon,
          width: 40.w,
          height: 40.h,
          color: ThemeHelper.white,
        ),
        label: "Qr-code",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          IconsImages.profileIcon,
          width: 40.w,
          height: 40.h,
          color: ThemeHelper.white50,
        ),
        activeIcon: Image.asset(
          IconsImages.profileIcon,
          width: 40.w,
          height: 40.h,
          color: ThemeHelper.white,
        ),
        label: "Профиль",
      ),
    ];
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _generateItemList(),
      selectedItemColor: ThemeHelper.white,
      unselectedItemColor: ThemeHelper.white50,
      selectedLabelStyle: TextStyleHelper.labelStyle,
      unselectedLabelStyle: TextStyleHelper.labelStyle,
      showUnselectedLabels: true,
      backgroundColor: ThemeHelper.green80,
      iconSize: 24,
      unselectedFontSize: 14,
      onTap: (index) async {
        switch (index) {
          case 0:
            {
              if (currentPage != index) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BranchScreen(),
                  ),
                );
              }
              break;
            }
          case 1:
            {
              if (currentPage != index) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BalanceScreen(),
                  ),
                );
              }
              break;
            }
          case 2:
            {
              if (currentPage != index) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QrCodeScreen(),
                  ),
                );
              }
              break;
            }
          case 3:
            {
              if (currentPage != index) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileSceen(),
                  ),
                );
              }
              break;
            }
        }
      },
      currentIndex: currentPage,
      type: BottomNavigationBarType.fixed,
    );
  }
}
