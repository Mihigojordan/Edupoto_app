import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class ShopRepo{
  final ApiClient apiClient;

  ShopRepo({required this.apiClient});

  Future<Response> getShopListApi() async {
    return await apiClient.getData(AppConstants.shop);
  }
}