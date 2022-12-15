import 'package:feliz_coin/commons/text_style_helper.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:feliz_coin/global_widgets/cashed_network_image.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxCatalogProductsWidget extends StatelessWidget {
  final String? imageUrl;
  final String? productName;
  final String? productType;
  final String? price;
  final String? cashBack;

  const BoxCatalogProductsWidget({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.productType,
    required this.price,
    required this.cashBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260.w,
      height: 98.h,
      decoration: BoxDecoration(
        color: ThemeHelper.brown80,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 18.w),
        child: Row(
          children: [
            CustomCachedNetworkImageWidget(
              imageUrl: imageUrl,
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
                    productName ?? 'unknown',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleHelper.productNameBrown80
                        .copyWith(color: ThemeHelper.white),
                  ),
                ),
                SizedBox(
                  width: 90.w,
                  child: Text(
                    productType ?? 'unknown',
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
                        '${price ?? 00.0} сом/ ',
                        style: TextStyleHelper.f12fw600
                            .copyWith(color: ThemeHelper.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7.w),
                        child: Row(
                          children: [
                            Text('+ ${cashBack ?? 0}',
                                style: TextStyleHelper.f16fw700),
                            ImageIcon(
                              const AssetImage('assets/images/coin.png'),
                              color: ThemeHelper.yellow,
                              size: 12,
                            ),
                          ],
                        ),
                      )
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