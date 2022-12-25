import 'dart:developer';

import 'package:feliz_coin/commons/text_style_helper.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:feliz_coin/global_widgets/cashed_network_image.dart.dart';
import 'package:feliz_coin/global_widgets/product_quantity_widget.dart';
import 'package:feliz_coin/models/product_model.dart';
import 'package:feliz_coin/screens/auth_screen/local_widgets/auth_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../global_widgets/loadingIndicator_widget.dart';
import '../sale_product/sale_product_bloc.dart';

class ProductDialogBox extends StatefulWidget {
  final ProductModel productModel;
  final SaleProductBloc? saleProductBloc;
  final bool? isSale;
  final int? saleId;

  const ProductDialogBox({
    Key? key,
    required this.productModel,
    this.isSale,
    this.saleId,
    this.saleProductBloc,
  }) : super(key: key);

  @override
  State<ProductDialogBox> createState() => _ProductDialogBoxState();
}

class _ProductDialogBoxState extends State<ProductDialogBox> {
  int quantity = 0;
  // late SaleProductBloc _saleProductBloc;

  @override
  void initState() {
    // _saleProductBloc = SaleProductBloc();
    super.initState();
  }

  void _increQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SaleProductBloc saleProductBloc =
        widget.saleProductBloc ?? SaleProductBloc();
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      titlePadding: EdgeInsets.only(top: 20.h, left: 50.w, right: 50.w),
      title: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              blurRadius: 15.r,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: CustomCachedNetworkImageWidget(
          imageUrl: widget.productModel.image,
          width: 40.w,
          height: 150.h,
          shape: BoxShape.circle,
        ),
      ),
      contentPadding: EdgeInsets.only(
        top: 20.h,
        left: 30.w,
        right: 30.w,
        bottom: 20.h,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.productModel.title ?? 'unknown',
                textAlign: TextAlign.center,
                style: TextStyleHelper.f20w700
                    .copyWith(color: ThemeHelper.green80),
              ),
              Text(
                '${widget.productModel.price ?? 00.0} com',
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
                'Кэш:',
                textAlign: TextAlign.center,
                style: TextStyleHelper.f16Green100
                    .copyWith(color: ThemeHelper.green80),
              ),
              Text(
                '${widget.productModel.percentCashback ?? 'unknown'} %',
                textAlign: TextAlign.center,
                style: TextStyleHelper.f16fw700
                    .copyWith(color: ThemeHelper.yellow),
              ),
            ],
          ),
          SizedBox(height: 20.w),
          Text(
            widget.productModel.description ?? 'unknown',
            textAlign: TextAlign.center,
            style:
                TextStyleHelper.f16fw700.copyWith(color: ThemeHelper.green60),
          ),
          SizedBox(height: 20.h),
          widget.isSale ?? false
              ? Column(
                  children: [
                    ProductQuantityWidget(
                      increment: () {
                        _increQuantity();
                      },
                      decrement: () {
                        _decreQuantity();
                      },
                      quantity: quantity,
                    ),
                    SizedBox(height: 20.h),
                    BlocConsumer<SaleProductBloc, SaleProductState>(
                      bloc: saleProductBloc,
                      listener: (context, state) {
                        if (state is ErrorSaleProductState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.message.toString(),
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AddingProductToBasketState) {
                          return LoadingIndicatorWidget(
                            height: 40.h,
                            width: 40.w,
                            color: ThemeHelper.brown80,
                          );
                        }

                        if (state is DeletingProductFromBasketState) {
                          return LoadingIndicatorWidget(
                            height: 40.h,
                            width: 40.w,
                            color: ThemeHelper.brown80,
                          );
                        }
                        if (state is DeletedProductFromBasketState) {
                          return AuthButtonWidget(
                            txtButton: 'Добавить в корзину',
                            themeButton: ThemeHelper.brown80,
                            textColor: ThemeHelper.white,
                            width: 150.w,
                            height: 40.h,
                            function: () {
                              saleProductBloc.add(
                                AddingProductToBasketEvent(
                                  saleId: widget.saleId!,
                                  productId: widget.productModel.id!,
                                  amount: quantity,
                                ),
                              );
                            },
                          );
                        }
                        if (state is AddedProductToBasketState) {
                          return AuthButtonWidget(
                            txtButton: 'Добавлено, назад',
                            themeButton: ThemeHelper.brown80,
                            textColor: ThemeHelper.white,
                            width: 150.w,
                            height: 40.h,
                            function: () => Navigator.pop(context),
                          );
                        }
                        return AuthButtonWidget(
                          txtButton: 'Добавить в корзину',
                          themeButton: ThemeHelper.brown80,
                          textColor: ThemeHelper.white,
                          width: 150.w,
                          height: 40.h,
                          function: () {
                            saleProductBloc.add(
                              AddingProductToBasketEvent(
                                saleId: widget.saleId!,
                                productId: widget.productModel.id!,
                                amount: quantity,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
              : IconButton(
                  iconSize: 40.r,
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.highlight_off_outlined,
                    color: ThemeHelper.green80,
                  ),
                ),
        ],
      ),
    );
  }
}
