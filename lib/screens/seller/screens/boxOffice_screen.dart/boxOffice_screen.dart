import 'package:feliz_coin/commons/icon_images.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:feliz_coin/global_widgets/appCover_widget.dart';
import 'package:feliz_coin/global_widgets/search_textfield_widget.dart';
import 'package:feliz_coin/screens/seller/screens/boxOffice_screen.dart/cashBox_screen.dart';
import 'package:feliz_coin/screens/seller/screens/boxOffice_screen.dart/local_widget/history_button_widget.dart';
import 'package:feliz_coin/screens/seller/seller_navigation/seller_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxOfficeScreen extends StatefulWidget {
  const BoxOfficeScreen({Key? key}) : super(key: key);

  @override
  State<BoxOfficeScreen> createState() => _BoxOfficeScreenState();
}

class _BoxOfficeScreenState extends State<BoxOfficeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppCoverWidget(nameCover: 'КАССА', isSeller: true),
            SizedBox(height: 22.h),
            SearchTextFieldWidget(
              fillColor: ThemeHelper.brown20,
              hintTextColor: ThemeHelper.brown80,
              hintText: 'DD/MM/YY',
              suffix: ImageIcon(
                AssetImage(IconsImages.iconVbrown),
                color: ThemeHelper.brown80,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(left: 21.w, top: 51.h, right: 21.w),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: HistoryButton(
                      som: 1500,
                      dateTimeBalance: '06.06.22',
                      balance: 78,
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CashBoxScreen(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SellerNavigationWidget(currentPage: 2),
    );
  }
}
