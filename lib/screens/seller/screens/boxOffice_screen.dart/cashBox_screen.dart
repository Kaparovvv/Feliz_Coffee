import 'package:feliz_coin/commons/icon_images.dart';
import 'package:feliz_coin/global_widgets/appCover_widget.dart';
import 'package:feliz_coin/global_widgets/search_textfield_widget.dart';
import 'package:feliz_coin/screens/seller/screens/boxOffice_screen.dart/local_widget/clients_cashBox.dart';
import 'package:feliz_coin/screens/seller/screens/boxOffice_screen.dart/local_widget/phone_number.dart';
import 'package:feliz_coin/screens/seller/seller_navigation/seller_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CashBoxScreen extends StatefulWidget {
  const CashBoxScreen({Key? key}) : super(key: key);

  @override
  State<CashBoxScreen> createState() => _CashBoxScreenState();
}

class _CashBoxScreenState extends State<CashBoxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppCoverWidget(
              nameCover: 'КАССА',
              isSeller: true,
              isBackButton: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 22.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchTextFieldWidget(
                      hintText: 'DD/MM/YY',
                      suffix: Image.asset(IconsImages.iconVbrown),
                      fillColor: null,
                      hintTextColor: Colors.red,
                    ),
                    SizedBox(
                      width: 1.sw,
                      height: 550.h,
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Column(
                            children: const [
                              PhoneNumber(phoneNumber: '+996 555 55 55 55'),
                              ClientsCashBox(),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SellerNavigationWidget(currentPage: 2),
    );
  }
}
