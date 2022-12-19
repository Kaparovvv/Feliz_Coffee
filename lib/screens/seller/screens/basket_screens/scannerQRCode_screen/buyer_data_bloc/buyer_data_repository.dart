import 'package:feliz_coin/models/user_data_model.dart';
import 'package:feliz_coin/screens/seller/screens/basket_screens/scannerQRCode_screen/buyer_data_bloc/buyer_data_provider.dart';

class BuyerDataRepository {
  Future<UserDataModel> getBuyerData({required String buyerId}) {
    BuyerDataProvider buyerDataProvider = BuyerDataProvider();

    return buyerDataProvider.getBuyerData(buyerId: buyerId);
  }
}
