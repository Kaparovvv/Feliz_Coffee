import 'package:feliz_coin/commons/icon_images.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:feliz_coin/global_widgets/appCover_widget.dart';
import 'package:feliz_coin/global_widgets/loading_overlay_widget.dart';
import 'package:feliz_coin/screens/seller/screens/basket_screens/basket_screen/create_sale_bloc/create_sale_bloc.dart';
import 'package:feliz_coin/screens/seller/screens/basket_screens/basket_screen/local_widgets/buttonWithIcon_widget.dart';
import 'package:feliz_coin/screens/seller/screens/basket_screens/scannerQRCode_screen/scannerQRCode_screen.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/catalog_screen/catalog_screen.dart';
import 'package:feliz_coin/screens/seller/seller_navigation/seller_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  late CreateSaleBloc _createSaleBloc;
  Box userData = Hive.box('userDataBox');

  @override
  void initState() {
    _createSaleBloc = CreateSaleBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Column(
            children: [
              const AppCoverWidget(
                nameCover: 'КОРЗИНА',
                isSeller: true,
              ),
              SizedBox(height: 220.h),
              ButtonWithIconWidget(
                function: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScannerQRCodeScreen(),
                  ),
                ),
                buttonTxt: 'Сканировать QR-код',
                iconWidget: ImageIcon(
                  AssetImage(IconsImages.iconCamera),
                  size: 25,
                  color: ThemeHelper.green80,
                ),
              ),
              SizedBox(height: 32.h),
              ButtonWithIconWidget(
                function: () {
                  _createSaleBloc.add(
                    PostCreateSaleEvent(
                      branchId: userData.get('branchId'),
                      clientId: null,
                      fromBalanceAmount: null,
                      isSold: null,
                    ),
                  );
                },
                buttonTxt: 'Без приложения',
                iconWidget: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: ThemeHelper.green80,
                  size: 25,
                ),
              ),
            ],
          ),
          bottomNavigationBar: const SellerNavigationWidget(
            currentPage: 1,
          ),
        ),
        BlocConsumer<CreateSaleBloc, CreateSaleState>(
          bloc: _createSaleBloc,
          listener: (context, state) {
            if (state is ErrorCreateSaleState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message.toString(),
                  ),
                ),
              );
            }
            if (state is LoadedCreateSaleState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CatalogScreen(isSale: true),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingCreateSaleState) {
              return const LoadingOverlayWidget();
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
