import 'package:feliz_coin/commons/box_shadow_helper.dart';
import 'package:feliz_coin/commons/text_style_helper.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:feliz_coin/global_widgets/cashed_network_image.dart.dart';
import 'package:feliz_coin/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInfoBoxWidget extends StatelessWidget {
  final ProductModel productModel;
  final Function() onPressed;

  const ProductInfoBoxWidget({
    Key? key,
    required this.productModel,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      splashColor: Colors.grey,
      borderRadius: BorderRadius.circular(20.r),
      child: Ink(
        width: 334.w,
        height: 98.h,
        decoration: BoxDecoration(
          color: ThemeHelper.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [BoxShadowHelper.boxShadow25],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 19.w),
          child: Row(
            children: [
              CustomCachedNetworkImageWidget(
                imageUrl: productModel.image,
                width: 60.w,
                height: 60.h,
                radius: BorderRadius.circular(10.r),
              ),
              SizedBox(width: 13.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.title ?? 'unknown',
                    style: TextStyleHelper.productNameGreen80,
                  ),
                  Text(
                    productModel.category!.name ?? 'unknown',
                    style: TextStyleHelper.f14fw500,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 120.w),
                    child: Row(
                      children: [
                        Text(
                          '${productModel.price ?? 00.0} сом/ ',
                          style: TextStyleHelper.f12fw600,
                        ),
                        Row(
                          children: [
                            Text('+ ${productModel.percentCashback}',
                                style: TextStyleHelper.f16w4000),
                            ImageIcon(
                              const AssetImage('assets/images/coin.png'),
                              color: ThemeHelper.yellow,
                              size: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
