import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketInitial()) {
    on<BasketEvent>((event, emit) {
      if (event is AddProductToBasketEvent) {
        emit(ProductIsNotBasketState());

        // productOfList.add(event.productOfList);

        // emit(
        //   ProductInBasketState(productOfList: productOfList),
        // );

        if (event is GetProductInBasketEvent) {
          // emit(
          //   ProductInBasketState(productOfList: productOfList),
          // );
        }
      }

      if (event is DeleteProductFromBasketEvent) {
        // for (int i = 0; i < basketModel!.result!.length; i++) {
        //   if (basketModel.result) {

        //   }
        // }
        emit(ProductIsNotBasketState());
      }
    });
  }
}
