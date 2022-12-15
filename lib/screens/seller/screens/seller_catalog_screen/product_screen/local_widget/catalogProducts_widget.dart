import 'package:feliz_coin/commons/icon_images.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:feliz_coin/models/product_model.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/catalog_screen/catalog_screen.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/product_screen/local_widget/boxCatalogProducts_widget.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/product_screen/local_widget/circleButton_widget.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/local_blocs/basket_bloc/basket_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatalogProductWidget extends StatefulWidget {
  final ProductModel productList;
  final bool isSale;

  const CatalogProductWidget({
    Key? key,
    required this.productList,
    this.isSale = false,
  }) : super(key: key);

  @override
  State<CatalogProductWidget> createState() => _CatalogProductWidgetState();
}

class _CatalogProductWidgetState extends State<CatalogProductWidget> {
  late BasketBloc _basketBloc;

  @override
  void initState() {
    _basketBloc = BasketBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSale
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoxCatalogProductsWidget(
                productList: widget.productList,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocConsumer<BasketBloc, BasketState>(
                    bloc: _basketBloc,
                    listener: (context, state) {
                      if (state is ProductInBasketState) {
                        // log(state.productOfList.length.toString());
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: SizedBox(
                        //       width: 300.w,
                        //       height: 150.h,
                        //       child: ListView.builder(
                        //         itemCount: state.productOfList.length,
                        //         itemBuilder: (context, index) {
                        //           var product = state.productOfList[index];
                        //           return Text(
                        //             '${product.category},\n${product.productData![index].name},\n ${product.productData![index].price}\n ${product.productData![index].percentCashback}',
                        //           );
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // );
                      }
                    },
                    builder: (context, state) {
                      if (state is ProductIsNotBasketState) {
                        return CircleButtonWidget(
                          isAdd: false,
                          function: () {
                            // _basketBloc.add(
                            //   AddProductToBasketEvent(
                            //     productOfList: ProductOfList(
                            //       category: value.category!.name,
                            //       productData: [
                            //         ProductData(
                            //           name: value.title,
                            //           price: value.price,
                            //           percentCashback: value.percentCashback,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // );
                          },
                          iconWidget: Icon(
                            Icons.add,
                            color: ThemeHelper.brown80,
                            size: 23,
                          ),
                        );
                      }
                      if (state is ProductInBasketState) {
                        return CircleButtonWidget(
                          isAdd: true,
                          function: () =>
                              _basketBloc.add(DeleteProductFromBasketEvent()),
                          iconWidget: Icon(
                            Icons.done,
                            color: ThemeHelper.white,
                            size: 23,
                          ),
                        );
                      }
                      return CircleButtonWidget(
                        function: () {
                          // _basketBloc.add(
                          //   AddProductToBasketEvent(
                          //     productOfList: ProductOfList(
                          //       category: value.category!.name,
                          //       productData: [
                          //         ProductData(
                          //           name: value.title,
                          //           price: value.price,
                          //           percentCashback: value.percentCashback,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // );
                        },
                        iconWidget: Icon(
                          Icons.add,
                          color: ThemeHelper.brown80,
                          size: 23,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  CircleButtonWidget(
                    function: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CatalogScreen(
                          isSale: widget.isSale,
                        ),
                      ),
                    ),
                    iconWidget: ImageIcon(
                      AssetImage(
                        IconsImages.iconBasket,
                      ),
                      color: ThemeHelper.brown80,
                      size: 23,
                    ),
                  ),
                ],
              ),
            ],
          )
        : BoxCatalogProductsWidget(
            productList: widget.productList,
          );
  }
}
