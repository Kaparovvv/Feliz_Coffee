import 'dart:developer';

import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:feliz_coin/global_blocs/product_bloc/product_bloc.dart';
import 'package:feliz_coin/global_widgets/appCover_widget.dart';
import 'package:feliz_coin/global_widgets/loading_overlay_widget.dart';
import 'package:feliz_coin/global_widgets/refresh_indicator_widget.dart';
import 'package:feliz_coin/global_widgets/show_dialog_widget.dart';
import 'package:feliz_coin/screens/seller/screens/basket_screens/basket_screen/sale_bloc/sale_bloc.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/catalog_screen/bloc_consumers/category_consumer.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/catalog_screen/local_blocs/confirm_button_bloc/confirm_button_bloc.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/catalog_screen/local_widgets/confirm_button_widget.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/local_blocs/category_bloc/category_bloc.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/product_screen/sale_product/sale_product_bloc.dart';
import 'package:feliz_coin/screens/seller/seller_navigation/seller_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatalogScreen extends StatefulWidget {
  bool? isSale;
  final int? saleId;
  CatalogScreen({
    Key? key,
    this.isSale = false,
    this.saleId,
  }) : super(key: key);

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late CategoryBloc _categoryBloc;
  late ConfirmButtonBloc _confirmButtonBloc;
  late SaleBloc _saleBloc;

  @override
  void initState() {
    log('Catalog Sale ID ===== ${widget.saleId}');
    _categoryBloc = CategoryBloc();
    _categoryBloc.add(GetCategoryEvent());
    _confirmButtonBloc = ConfirmButtonBloc();
    _saleBloc = SaleBloc();
    switch (widget.isSale) {
      case true:
        _confirmButtonBloc.add(SaleSuccessfulCreatedEvent());
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const AppCoverWidget(
                  nameCover: 'КАТАЛОГ',
                  isSeller: true,
                ),
                Expanded(
                  child: RefreshIndicatorWidget(
                    onRefresh: () async => _categoryBloc.add(
                      GetCategoryEvent(),
                    ),
                    color: ThemeHelper.brown80,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 39.h),
                        child: CategoryConsumer(
                          categoryBloc: _categoryBloc,
                          widget: widget,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton:
              BlocBuilder<ConfirmButtonBloc, ConfirmButtonState>(
            bloc: _confirmButtonBloc,
            builder: (context, state) {
              if (state is CreatedConfirmButtonsState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ConfirmButtonWidget(
                      onPressed: () {
                        _saleBloc.add(
                          DeleteSaleEvent(
                            saleId: widget.saleId.toString(),
                          ),
                        );
                      },
                      isConfirm: false,
                    ),
                    ConfirmButtonWidget(
                      isConfirm: true,
                      onPressed: () {},
                    ),
                  ],
                );
              }

              if (state is DeletedConfirmButtonsState) {
                return const SizedBox();
              }
              return const SizedBox();
            },
          ),
          bottomNavigationBar: widget.isSale!
              ? const SizedBox()
              : const SellerNavigationWidget(currentPage: 0),
        ),
        BlocConsumer<SaleBloc, SaleState>(
          bloc: _saleBloc,
          listener: (context, state) {
            if (state is ErrorSaleState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message.toString(),
                  ),
                ),
              );
            }
            if (state is LoadedDeleteSaleState) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ShowDialogWidget(
                    isSeller: true,
                    contentText: 'Продажа успешно удалено!',
                    buttonText: 'Перейти в каталог',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 20.h,
                    ),
                    buttonPadding: EdgeInsets.only(bottom: 20.h),
                    onPressed: () {
                      _confirmButtonBloc.add(SaleSuccessfulDeletedEvent());
                      setState(() {
                        widget.isSale = false;
                      });
                      switch (widget.isSale) {
                        case false:
                          Navigator.pop(context);
                          break;
                      }
                    },
                  );
                },
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingDeleteSaleState) {
              return const LoadingOverlayWidget();
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
