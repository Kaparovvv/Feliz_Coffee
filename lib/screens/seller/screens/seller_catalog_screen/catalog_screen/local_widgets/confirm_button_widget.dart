import 'package:feliz_coin/commons/icon_images.dart';
import 'package:feliz_coin/commons/text_style_helper.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final bool isConfirm;

  const ConfirmButtonWidget({
    Key? key,
    required this.onPressed,
    required this.isConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeHelper.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isConfirm ? ThemeHelper.green100 : ThemeHelper.red,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        elevation: 7,
        shadowColor: isConfirm ? ThemeHelper.green100 : ThemeHelper.red,
      ),
      child: Row(
        children: [
          Text(
            isConfirm ? 'В корзину' : 'Отменить',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyleHelper.productNameGreen80.copyWith(
                color: isConfirm ? ThemeHelper.green80 : ThemeHelper.red),
          ),
          SizedBox(width: 10.w),
          isConfirm
              ? ImageIcon(
                  AssetImage(
                    IconsImages.iconBasket,
                  ),
                  color: ThemeHelper.green80,
                  size: 30,
                )
              : Icon(
                  Icons.cancel_outlined,
                  size: 30,
                  color: ThemeHelper.red,
                ),
        ],
      ),
    );
  }
}
