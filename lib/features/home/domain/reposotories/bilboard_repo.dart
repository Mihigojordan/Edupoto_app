import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class BilboardRepo{
  final ApiClient apiClient;

  BilboardRepo({required this.apiClient});

  Future<Response> getBilboardList(type) async {
    return await apiClient.getData('${AppConstants.customerBanner}/$type');
  }
}