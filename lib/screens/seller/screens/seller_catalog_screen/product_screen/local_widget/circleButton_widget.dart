import 'package:feliz_coin/commons/box_shadow_helper.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleButtonWidget extends StatelessWidget {
  final Widget iconWidget;
  final bool isAdd;
  final Function() function;
  const CircleButtonWidget({
    Key? key,
    required this.iconWidget,
    required this.function,
    this.isAdd = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function(),
      splashColor: Colors.grey.shade600,
      borderRadius: BorderRadius.circular(45.r),
      child: Ink(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: isAdd ? ThemeHelper.brown80 : ThemeHelper.white,
          boxShadow: [BoxShadowHelper.boxShadow25],
          shape: BoxShape.circle,
        ),
        child: Center(child: iconWidget),
      ),
    );
  }
}
