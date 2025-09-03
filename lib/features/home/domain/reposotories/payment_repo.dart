import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class PaymentRepo{
  final ApiClient apiClient;

  PaymentRepo({required this.apiClient});

  Future<Response> makePaymentApi() async {
    return await apiClient.getData(AppConstants.paymentHistory);
  }
}