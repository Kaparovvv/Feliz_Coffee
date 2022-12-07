import 'package:feliz_coin/models/branch_model.dart';
import 'package:feliz_coin/screens/buyer/screens/branch_screen/bloc/branch_provider.dart';

class BranchRepository {
  Future<List<BranchModel>> getBranch({String? branchName}) {
    BranchProvider branchProvider = BranchProvider();

    return branchProvider.getBranch(branchName: branchName);
  }
}
