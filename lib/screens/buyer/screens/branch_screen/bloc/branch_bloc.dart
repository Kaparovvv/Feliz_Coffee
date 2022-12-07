import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/branch_model.dart';
import 'package:feliz_coin/screens/buyer/screens/branch_screen/bloc/repository_branch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  BranchBloc() : super(BranchInitial()) {
    on<BranchEvent>(
      (event, emit) async {
        if (event is GetBranchEvent) {
          emit(LoadingBranchState());
          try {
            List<BranchModel> branchModelList = await BranchRepository()
                .getBranch(branchName: event.branchName);

            emit(
              LoadedBranchState(branchModelList: branchModelList),
            );
          } catch (e) {
            emit(
              ErrorBranchState(
                message: CatchException.convertException(e),
              ),
            );
          }
        }
      },
    );
  }
}
