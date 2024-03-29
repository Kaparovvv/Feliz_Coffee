import 'package:feliz_coin/commons/icon_images.dart';
import 'package:feliz_coin/commons/text_style_helper.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:feliz_coin/global_widgets/appCover_widget.dart';
import 'package:feliz_coin/global_widgets/search_textfield_widget.dart';
import 'package:feliz_coin/models/branch_model.dart';
import 'package:feliz_coin/screens/buyer/buyer_navigation_widget.dart/buyer_navigation_widget.dart';
import 'package:feliz_coin/screens/buyer/screens/shop_screen/local_widgets/product_name_widget.dart';
import 'package:feliz_coin/screens/buyer/screens/product_buyer_screen/product_buyer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopScreen extends StatefulWidget {
  final List<ListCategory> listOfCategory;
  const ShopScreen({Key? key, required this.listOfCategory}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppCoverWidget(
              nameCover: 'КАТАЛОГ',
              isSeller: false,
              isBackButton: true,
            ),
            SizedBox(height: 39.h),
            SearchTextFieldWidget(
              fillColor: ThemeHelper.green20,
              hintTextColor: ThemeHelper.green80,
              hintText: 'Поиск',
              prefix: ImageIcon(
                AssetImage(IconsImages.searchIcon),
                color: ThemeHelper.green80,
              ),
            ),
            Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.only(top: 57.h),
                  itemCount: widget.listOfCategory.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 80.w,
                    mainAxisSpacing: 53.w,
                    crossAxisCount: 2,
                    crossAxisSpacing: 54.h,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 21.w),
                      child: ProductNameWidget(
                        productName: widget.listOfCategory[index].name,
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BuyerProductScreen(
                                categoryId: widget.listOfCategory[index].id!,
                              ),
                            ),
                          );
                        },
                        borderColor: ThemeHelper.green50,
                        textStyle: TextStyleHelper.productNameGreen80,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BuyerNavigationWidget(currentPage: 0),
    );
  }
}
