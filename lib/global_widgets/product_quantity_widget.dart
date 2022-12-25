import 'package:feliz_coin/commons/text_style_helper.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductQuantityWidget extends StatefulWidget {
  final Function() increment;
  final Function() decrement;
  final int quantity;
  const ProductQuantityWidget({
    Key? key,
    required this.increment,
    required this.decrement,
    required this.quantity,
  }) : super(key: key);

  @override
  State<ProductQuantityWidget> createState() => _ProductQuantityWidgetState();
}

class _ProductQuantityWidgetState extends State<ProductQuantityWidget> {
  // @override
  // void dispose() {
  //   widget.quantityOfProduct;
  //   super.dispose();
  // }

  // void _increQuantity(int value) {
  //   setState(() {
  //     value++;
  //   });
  // }

  // void _decreQuantity(int value) {
  //   if (value > 0) {
  //     setState(() {
  //       value--;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        addButton(
          () => widget.decrement(),
          Icon(
            Icons.remove,
            color: ThemeHelper.blackDial,
          ),
        ),
        Text(
          widget.quantity.toString(),
          style: TextStyleHelper.f20w700.copyWith(
            color: ThemeHelper.blackDial,
            fontWeight: FontWeight.w700,
          ),
        ),
        addButton(
          () => widget.increment(),
          Icon(
            Icons.add,
            color: ThemeHelper.blackDial,
          ),
        ),
      ],
    );
  }

  Material addButton(Function() onPressed, Icon iconName) {
    return Material(
      borderRadius: BorderRadius.circular(15.r),
      child: InkWell(
        onTap: () => onPressed(),
        onLongPress: () => onPressed(),
        borderRadius: BorderRadius.circular(15.r),
        child: Ink(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: ThemeHelper.bejGray,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Center(
            child: iconName,
          ),
        ),
      ),
    );
  }
}
