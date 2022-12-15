import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/create_sale_model.dart';
import 'package:feliz_coin/screens/seller/screens/basket_screens/basket_screen/create_sale_bloc/create_sale_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'create_sale_event.dart';
part 'create_sale_state.dart';

class CreateSaleBloc extends Bloc<CreateSaleEvent, CreateSaleState> {
  CreateSaleBloc() : super(CreateSaleInitial()) {
    on<PostCreateSaleEvent>((event, emit) async {
      emit(LoadingCreateSaleState());
      try {
        CreateSaleModel createSaleModel =
            await CreateSaleRepository().createSale(
          branchId: event.branchId,
          clientId: event.clientId,
          fromBalanceAmount: event.fromBalanceAmount,
          isSold: event.isSold,
        );

        emit(
          LoadedCreateSaleState(createSaleModel: createSaleModel),
        );
      } catch (e) {
        emit(
          ErrorCreateSaleState(
            message: CatchException.convertException(e),
          ),
        );
      }
    });
  }
}
