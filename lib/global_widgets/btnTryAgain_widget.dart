import 'package:feliz_coin/commons/text_style_helper.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonTryAgainWidget extends StatelessWidget {
  final Function() onPressed;
  final Color btnTheme;
  const ButtonTryAgainWidget({
    Key? key,
    required this.onPressed,
    required this.btnTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Произошла системная ошибка, повторите попытку',
            textAlign: TextAlign.center,
            style: TextStyleHelper.f16Green100,
          ),
          ElevatedButton(
            onPressed: () => onPressed(),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
                vertical: 7.h,
              ),
              backgroundColor: btnTheme,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              shadowColor: ThemeHelper.brown80,
            ),
            child: Text(
              'Повторить',
              style: TextStyleHelper.functionBox,
            ),
          )
        ],
      ),
    );
  }
}
