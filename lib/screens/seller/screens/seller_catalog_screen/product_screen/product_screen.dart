import 'package:feliz_coin/commons/icon_images.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:feliz_coin/global_blocs/product_bloc/product_bloc.dart';
import 'package:feliz_coin/global_widgets/appCover_widget.dart';
import 'package:feliz_coin/global_widgets/btnTryAgain_widget.dart';
import 'package:feliz_coin/global_widgets/loadingIndicator_widget.dart';
import 'package:feliz_coin/global_widgets/refresh_indicator_widget.dart';
import 'package:feliz_coin/global_widgets/search_textfield_widget.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/product_screen/local_widget/catalogProducts_widget.dart';
import 'package:feliz_coin/screens/seller/seller_navigation/seller_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSellerScreen extends StatefulWidget {
  final int categoryId;
  final bool isSale;
  const ProductSellerScreen({
    Key? key,
    required this.categoryId,
    required this.isSale,
  }) : super(key: key);

  @override
  State<ProductSellerScreen> createState() => _ProductSellerScreenState();
}

class _ProductSellerScreenState extends State<ProductSellerScreen> {
  late ProductBloc _productBloc;

  @override
  void initState() {
    _productBloc = ProductBloc();
    _productBloc.add(GetProductEvent(categoryId: widget.categoryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppCoverWidget(
              nameCover: 'КАТАЛОГ',
              isSeller: true,
              isBackButton: true,
            ),
            Expanded(
              child: RefreshIndicatorWidget(
                color: ThemeHelper.brown80,
                onRefresh: () async => _productBloc
                    .add(GetProductEvent(categoryId: widget.categoryId)),
                child: BlocConsumer<ProductBloc, ProductState>(
                  bloc: _productBloc,
                  listener: (context, state) {
                    if (state is ProductErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error.message!),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ProductLoadingState) {
                      return LoadingIndicatorWidget(
                        height: 40.h,
                        width: 40.w,
                        color: ThemeHelper.brown80,
                      );
                    }

                    if (state is ProductErrorState) {
                      return ButtonTryAgainWidget(
                        onPressed: () => _productBloc.add(
                          GetProductEvent(categoryId: widget.categoryId),
                        ),
                        btnTheme: ThemeHelper.brown80,
                      );
                    }

                    if (state is ProductFetchedState) {
                      return Column(
                        children: [
                          SizedBox(height: 39.h),
                          SearchTextFieldWidget(
                            hintText: 'Поиск',
                            prefix: ImageIcon(
                              AssetImage(IconsImages.searchIcon),
                              color: ThemeHelper.brown80,
                            ),
                            fillColor: ThemeHelper.brown20,
                            hintTextColor: ThemeHelper.brown80,
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.only(
                                left: 20.w,
                                top: 21.h,
                                right: 20.w,
                              ),
                              itemCount: state.listOfProduct.length,
                              itemBuilder: (context, index) {
                                return CatalogProductWidget(
                                  isSale: widget.isSale,
                                  productList: state.listOfProduct[index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 28.h);
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const SellerNavigationWidget(currentPage: 0),
    );
  }
}
