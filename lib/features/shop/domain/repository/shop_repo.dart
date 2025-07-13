import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/data/api/woocommerce_api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class ShopRepo{
  final WoocommerceApiClient apiClient;

  ShopRepo({required this.apiClient});

  Future<Response> getProductListApi() async {
    return await apiClient.getData();
  }

  Future<Response> getCategoryListApi() async {
    return await apiClient.getProductGroupData(AppConstants.getCategory);
  }

 Future<Response> getBrandListApi() async {
    return await apiClient.getProductGroupData(AppConstants.getBrand);
  }

   Future<Response> getAttributeListApi() async {
    return await apiClient.getProductGroupData(AppConstants.getAttribute);
  }
}