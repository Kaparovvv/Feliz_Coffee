import 'package:feliz_coin/commons/sale_deleted.dart';
import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/create_sale_model.dart';
import 'package:feliz_coin/screens/seller/screens/basket_screens/basket_screen/sale_bloc/sale_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends Bloc<SaleEvent, SaleState> {
  SaleBloc() : super(SaleInitial()) {
    on<PostCreateSaleEvent>((event, emit) async {
      emit(LoadingCreateSaleState());
      try {
        CreateSaleModel createSaleModel = await SaleRepository().createSale(
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
          ErrorSaleState(
            message: CatchException.convertException(e),
          ),
        );
      }
    });

    on<DeleteSaleEvent>((event, emit) async {
      emit(LoadingDeleteSaleState());
      try {
        SaleDeleted saleDeleted =
            await SaleRepository().deleteSale(saleId: event.saleId);

        emit(LoadedDeleteSaleState(saleDeleted: saleDeleted));
      } catch (e) {
        emit(
          ErrorSaleState(
            message: CatchException.convertException(e),
          ),
        );
      }
    });
  }
}
