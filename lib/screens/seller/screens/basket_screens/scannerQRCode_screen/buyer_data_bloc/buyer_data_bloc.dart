import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/user_data_model.dart';
import 'package:feliz_coin/screens/seller/screens/basket_screens/scannerQRCode_screen/buyer_data_bloc/buyer_data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'buyer_data_event.dart';
part 'buyer_data_state.dart';

class BuyerDataBloc extends Bloc<BuyerDataEvent, BuyerDataState> {
  BuyerDataBloc() : super(BuyerDataInitial()) {
    on<GetBuyerDataEvent>((event, emit) async {
      emit(LoadingBuyerDataState());
      try {
        UserDataModel buyerDataModel =
            await BuyerDataRepository().getBuyerData(buyerId: event.buyerId);

        emit(
          LoadedBuyerDataState(buyerDataModel: buyerDataModel),
        );
      } catch (e) {
        emit(
          ErrorBuyerDataState(
            message: CatchException.convertException(e),
          ),
        );
      }
    });
  }
}
