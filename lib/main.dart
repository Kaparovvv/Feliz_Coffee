import 'package:feliz_coin/screens/buyer/screens/shop_screen/shop_screen.dart';
import 'package:feliz_coin/screens/seller/screens/basket_screens/basket_screen/basket_screen.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/catalog_screen/catalog_screen.dart';
import 'package:feliz_coin/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('tokenBox');
  await Hive.openBox('userIdBox');
  await Hive.openBox('pincodeBox');
  await Hive.openBox('emailBox');
  await Hive.openBox<dynamic>('userDataBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Feliz Logo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CatalogScreen(),
      ),
    );
  }
}
