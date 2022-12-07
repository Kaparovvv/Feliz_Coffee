import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:feliz_coin/helper/api_requester.dart';
import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/branch_model.dart';

class BranchProvider {
  Future<List<BranchModel>> getBranch({String? branchName}) async {
    Map<String, String> queryParams = {
      'name': branchName ?? '',
    };
    try {
      ApiRequester requester = ApiRequester();
      Response response = await requester.toGet(
        '/v1/branch/',
        queryParam: queryParams,
      );
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        List<BranchModel> branchModelList = response.data
            .map<BranchModel>((el) => BranchModel.fromJson(el))
            .toList();
        return branchModelList;
      } else {
        throw CatchException.convertException(response);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
