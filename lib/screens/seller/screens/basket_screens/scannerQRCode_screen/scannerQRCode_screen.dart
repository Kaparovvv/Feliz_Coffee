import 'dart:convert';
import 'dart:developer';

import 'package:feliz_coin/commons/text_style_helper.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:feliz_coin/global_blocs/user_data_bloc/profile_bloc.dart';
import 'package:feliz_coin/global_widgets/content_dialog_widget.dart';
import 'package:feliz_coin/global_widgets/loading_overlay_widget.dart';
import 'package:feliz_coin/global_widgets/show_dialog_widget.dart';
import 'package:feliz_coin/screens/seller/screens/basket_screens/basket_screen/basket_screen.dart';
import 'package:feliz_coin/screens/seller/screens/basket_screens/scannerQRCode_screen/buyer_data_bloc/buyer_data_bloc.dart';
import 'package:feliz_coin/screens/seller/screens/basket_screens/scannerQRCode_screen/local_widgets/qrScannerOverlay_widget.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/catalog_screen/catalog_screen.dart';
import 'package:feliz_coin/screens/seller/seller_navigation/seller_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../basket_screen/sale_bloc/sale_bloc.dart';

class ScannerQRCodeScreen extends StatefulWidget {
  const ScannerQRCodeScreen({Key? key}) : super(key: key);

  @override
  State<ScannerQRCodeScreen> createState() => _ScannerQRCodeScreenState();
}

class _ScannerQRCodeScreenState extends State<ScannerQRCodeScreen> {
  late MobileScannerController _scannerController;
  bool isScanned = false;
  late BuyerDataBloc _buyerDataBloc;
  late SaleBloc _saleBloc;
  Box userData = Hive.box('userDataBox');

  @override
  void initState() {
    _buyerDataBloc = BuyerDataBloc();
    _saleBloc = SaleBloc();
    _scannerController = MobileScannerController();
    super.initState();
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 30.w),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              size: 35,
              color: ThemeHelper.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 262.h,
            left: 44.w,
            right: 44.w,
            child: Material(
              child: Container(
                width: 288.w,
                height: 287.5.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: MobileScanner(
                  allowDuplicates: false,
                  controller: _scannerController,
                  onDetect: (barcode, args) async {
                    await Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        if (barcode.rawValue == null) {
                          debugPrint('Не удалось отсканировать QR-code');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Не удалось отсканировать QR-code'),
                            ),
                          );
                        } else {
                          final String userId = barcode.rawValue!;
                          final decodeMap = json.decode(userId);
                          log(decodeMap['user_id'].toString());
                          setState(() {
                            isScanned = true;
                          });
                          if (barcode.rawValue!.isNotEmpty) {
                            _buyerDataBloc.add(
                              GetBuyerDataEvent(
                                buyerId: decodeMap['user_id'],
                              ),
                            );
                          }
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          isScanned
              ? const SizedBox()
              : QRScannerOverlayWidget(
                  overlayColour: Colors.black.withOpacity(0.7),
                ),
          BlocBuilder<BuyerDataBloc, BuyerDataState>(
            bloc: _buyerDataBloc,
            builder: (context, state) {
              if (state is LoadedBuyerDataState) {
                var clientData = state.buyerDataModel;
                return Center(
                  child: ContentDialogWidget(
                    title: 'QR-code отсканирован',
                    username: clientData.username,
                    cashback: clientData.cashbackAll,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 20.h,
                    ),
                    buttonPadding: EdgeInsets.only(bottom: 30.h),
                    onPressed: () => _saleBloc.add(
                      PostCreateSaleEvent(
                        branchId: userData.get('branchId'),
                        clientId: clientData.id,
                        fromBalanceAmount: null,
                        isSold: null,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          Positioned(
            top: 120.h,
            left: 15.w,
            right: 15.w,
            child: Column(
              children: [
                Text(
                  'Поместите QR-код в рамку',
                  style: TextStyleHelper.f20w700
                      .copyWith(color: ThemeHelper.white),
                ),
                SizedBox(height: 500.h),
                SizedBox(
                  width: 0.9.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: _scannerController.torchState,
                          builder: (context, state, child) {
                            switch (state as TorchState) {
                              case TorchState.off:
                                return const Icon(
                                  Icons.flash_off_rounded,
                                  color: Colors.grey,
                                );
                              case TorchState.on:
                                return const Icon(
                                  Icons.flash_on_rounded,
                                  color: Colors.yellow,
                                );
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => _scannerController.toggleTorch(),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: _scannerController.cameraFacingState,
                          builder: (context, state, child) {
                            switch (state as CameraFacing) {
                              case CameraFacing.front:
                                return const Icon(Icons.autorenew_rounded);
                              case CameraFacing.back:
                                return const Icon(Icons.loop_rounded);
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => _scannerController.switchCamera(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
              if (state is LoadedCreateSaleState) {
                dispose();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ShowDialogWidget(
                      isSeller: true,
                      contentText: 'Продажа успешно создано!',
                      buttonText: 'Перейти в корзину',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 20.h,
                      ),
                      buttonPadding: EdgeInsets.only(bottom: 20.h),
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CatalogScreen(
                            isSale: true,
                            saleId: state.createSaleModel.id,
                          ),
                        ),
                      ),
                    );
                  },
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
      ),
    );
  }
}
