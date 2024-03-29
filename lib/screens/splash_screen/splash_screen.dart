import 'dart:developer';

import 'package:feliz_coin/screens/auth_screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Box tokenBox = Hive.box('tokenBox');
  Box pincodeBox = Hive.box('pincodeBox');
  Box userIdBox = Hive.box('userIdBox');
  @override
  void initState() {
    log('TokenSplash ====== ${tokenBox.get('token')}');
    log('PincodeSplash ====== ${pincodeBox.get('pincode')}');
    log('UserIDSplash ====== ${userIdBox.get('userId')}');

    navigate();
    super.initState();
  }

  Future navigate() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 242.w,
          height: 242.h,
          child: Center(
            child: Image.asset('assets/images/splash_page.png'),
          ),
        ),
      ),
    );
  }
}
