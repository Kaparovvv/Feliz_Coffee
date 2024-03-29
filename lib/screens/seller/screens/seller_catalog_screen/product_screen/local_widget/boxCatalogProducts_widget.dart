import 'package:feliz_coin/commons/icon_images.dart';
import 'package:feliz_coin/commons/text_style_helper.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:feliz_coin/global_widgets/cashed_network_image.dart.dart';
import 'package:feliz_coin/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxCatalogProductsWidget extends StatelessWidget {
  final ProductModel productList;
  final Function() onPressed;

  const BoxCatalogProductsWidget({
    Key? key,
    required this.productList,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 19.h),
        decoration: BoxDecoration(
          color: ThemeHelper.brown80,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            CustomCachedNetworkImageWidget(
              imageUrl: productList.image,
              width: 60.w,
              height: 60.h,
              radius: BorderRadius.circular(10.r),
            ),
            SizedBox(width: 13.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150.w,
                  child: Text(
                    productList.title ?? 'unknown',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleHelper.productNameBrown80
                        .copyWith(color: ThemeHelper.white),
                  ),
                ),
                SizedBox(
                  width: 90.w,
                  child: Text(
                    productList.category!.name ?? 'unknown',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleHelper.f14fw500
                        .copyWith(color: ThemeHelper.white),
                  ),
                ),
                SizedBox(
                  width: 50.w,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 7.w),
                  child: Row(
                    children: [
                      Text(
                        '${productList.price ?? 00.0} сом /',
                        style: TextStyleHelper.f12fw600
                            .copyWith(color: ThemeHelper.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7.w),
                        child: Row(
                          children: [
                            Text('+ ${productList.percentCashback ?? 0}',
                                style: TextStyleHelper.f16fw700),
                            ImageIcon(
                              AssetImage(IconsImages.coin),
                              color: ThemeHelper.yellow,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
