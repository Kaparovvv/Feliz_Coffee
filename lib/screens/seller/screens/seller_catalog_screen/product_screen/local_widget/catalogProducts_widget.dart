import 'dart:developer';

import 'package:feliz_coin/commons/icon_images.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:feliz_coin/global_widgets/loadingIndicator_widget.dart';
import 'package:feliz_coin/models/product_model.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/product_screen/local_widget/product_dialog_box_widget.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/catalog_screen/catalog_screen.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/product_screen/local_widget/boxCatalogProducts_widget.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/product_screen/local_widget/circleButton_widget.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/product_screen/sale_product/sale_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CatalogProductWidget extends StatefulWidget {
  final ProductModel productList;
  final int? saleId;
  final bool isSale;

  const CatalogProductWidget({
    Key? key,
    required this.productList,
    required this.saleId,
    this.isSale = false,
  }) : super(key: key);

  @override
  State<CatalogProductWidget> createState() => _CatalogProductWidgetState();
}

class _CatalogProductWidgetState extends State<CatalogProductWidget> {
  late SaleProductBloc _saleProductBloc;
  @override
  void initState() {
    _saleProductBloc = SaleProductBloc();
    log('CatalogProduct Sale ID ===== ${widget.saleId}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProductModel product = widget.productList;
    return widget.isSale
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoxCatalogProductsWidget(
                onPressed: () {},
                productList: product,
              ),
              BlocConsumer<SaleProductBloc, SaleProductState>(
                bloc: _saleProductBloc,
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
                    return SizedBox(
                      height: 60.h,
                      width: 60.w,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballScaleMultiple,
                        colors: [
                          ThemeHelper.brown20,
                          ThemeHelper.brown50,
                          ThemeHelper.brown80,
                        ],
                      ),
                    );
                  }

                  if (state is DeletingProductFromBasketState) {
                    return SizedBox(
                      height: 60.h,
                      width: 60.w,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballScaleMultiple,
                        colors: [
                          ThemeHelper.brown20,
                          ThemeHelper.brown50,
                          ThemeHelper.brown80,
                        ],
                      ),
                    );
                  }
                  if (state is DeletedProductFromBasketState) {
                    return CircleButtonWidget(
                      isAdd: false,
                      iconWidget: Icon(
                        Icons.add,
                        color: ThemeHelper.brown80,
                        size: 30,
                      ),
                      function: () => showDialog(
                        context: context,
                        builder: (context) => ProductDialogBox(
                          saleProductBloc: _saleProductBloc,
                          saleId: widget.saleId,
                          productModel: product,
                          isSale: true,
                        ),
                      ),
                    );
                  }
                  if (state is AddedProductToBasketState) {
                    return CircleButtonWidget(
                      isAdd: true,
                      iconWidget: Icon(
                        Icons.done,
                        color: ThemeHelper.white,
                        size: 30,
                      ),
                      function: () => _saleProductBloc.add(
                        DeletingProductFromBasketEvent(
                          saleProductId: state.saleProductModel.id.toString(),
                        ),
                      ),
                    );
                  }
                  return CircleButtonWidget(
                    isAdd: false,
                    iconWidget: Icon(
                      Icons.add,
                      color: ThemeHelper.brown80,
                      size: 30,
                    ),
                    function: () => showDialog(
                      context: context,
                      builder: (context) => ProductDialogBox(
                        saleProductBloc: _saleProductBloc,
                        saleId: widget.saleId,
                        productModel: product,
                        isSale: true,
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        : BoxCatalogProductsWidget(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => ProductDialogBox(productModel: product),
            ),
            productList: product,
          );
  }
}
