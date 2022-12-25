import 'dart:developer';

import 'package:feliz_coin/commons/sale_deleted.dart';
import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/sale_product_model.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/product_screen/sale_product/sale_product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'sale_product_event.dart';
part 'sale_product_state.dart';

class SaleProductBloc extends Bloc<SaleProductEvent, SaleProductState> {
  SaleProductBloc() : super(SaleProductInitial()) {
    on<AddingProductToBasketEvent>((event, emit) async {
      log('event.saleId${event.saleId}\n event.productId${event.productId}\n event.amount${event.amount}');
      emit(AddingProductToBasketState());
      try {
        SaleProductModel saleProductModel =
            await SaleProductRepository().addingToBasket(
          saleId: event.saleId,
          productId: event.productId,
          amount: event.amount,
        );

        emit(
          AddedProductToBasketState(saleProductModel: saleProductModel),
        );
      } catch (e) {
        emit(
          ErrorSaleProductState(
            message: CatchException.convertException(e),
          ),
        );
      }
    });

    on<DeletingProductFromBasketEvent>((event, emit) async {
      emit(DeletingProductFromBasketState());
      try {
        ProductDeletedFromBasket isDeleted = await SaleProductRepository()
            .deletingFromBasket(saleProductId: event.saleProductId);

        emit(
          DeletedProductFromBasketState(isDeleted: isDeleted),
        );
      } catch (e) {
        emit(
          ErrorSaleProductState(
            message: CatchException.convertException(e),
          ),
        );
      }
    });
  }
}
