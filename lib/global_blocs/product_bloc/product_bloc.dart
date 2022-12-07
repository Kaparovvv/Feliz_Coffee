import 'package:feliz_coin/global_blocs/product_bloc/product_repository.dart';
import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetProductEvent) {
        emit(ProductLoadingState());

        try {
          List<ProductModel> listOfProduct =
              await ProductRepository().getProduct(event.categoryId);

          emit(ProductFetchedState(listOfProduct: listOfProduct));
        } catch (e) {
          emit(ProductErrorState(error: CatchException.convertException(e)));
        }
      }
    });
  }
}
