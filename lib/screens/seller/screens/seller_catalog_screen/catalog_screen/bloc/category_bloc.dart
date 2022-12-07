import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/category_seller_model.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/catalog_screen/bloc/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<GetCategoryEvent>(
      (event, emit) async {
        emit(LoadingCategoryState());
        try {
          CategorySellerModel categorySellerModel =
              await CategoryRepository().getCategory();

          emit(
            LoadedCategoryState(categorySellerModel: categorySellerModel),
          );
        } catch (e) {
          emit(
            ErrorCategoryState(
              message: CatchException.convertException(e),
            ),
          );
        }
      },
    );
  }
}
