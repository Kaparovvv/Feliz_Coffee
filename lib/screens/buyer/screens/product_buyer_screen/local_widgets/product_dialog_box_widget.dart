import 'package:feliz_coin/commons/text_style_helper.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:feliz_coin/global_widgets/cashed_network_image.dart.dart';
import 'package:feliz_coin/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDialogBox extends StatelessWidget {
  final ProductModel productModel;
  const ProductDialogBox({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      titlePadding: EdgeInsets.only(top: 20.h, left: 50.w, right: 50.w),
      title: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              blurRadius: 15.r,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: CustomCachedNetworkImageWidget(
          imageUrl: productModel.image,
          width: 40.w,
          height: 150.h,
          radius: BorderRadius.circular(10.r),
        ),
      ),
      contentPadding: EdgeInsets.only(top: 20.h, left: 40.w, right: 40.w),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                productModel.title!,
                textAlign: TextAlign.center,
                style: TextStyleHelper.f20w700
                    .copyWith(color: ThemeHelper.green80),
              ),
              Text(
                '${productModel.price!} com',
                textAlign: TextAlign.center,
                style: TextStyleHelper.f16fw700
                    .copyWith(color: ThemeHelper.yellow),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Кэшбек:',
                textAlign: TextAlign.center,
                style: TextStyleHelper.f16Green100
                    .copyWith(color: ThemeHelper.green80),
              ),
              Text(
                '${productModel.percentCashback!} %',
                textAlign: TextAlign.center,
                style: TextStyleHelper.f16fw700
                    .copyWith(color: ThemeHelper.yellow),
              ),
            ],
          ),
          SizedBox(height: 20.w),
          Text(
            productModel.description!,
            textAlign: TextAlign.center,
            style:
                TextStyleHelper.f16fw700.copyWith(color: ThemeHelper.green60),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: IconButton(
            iconSize: 40.r,
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.highlight_off_outlined,
              color: ThemeHelper.green80,
            ),
          ),
        ),
      ],
    );
  }
}
