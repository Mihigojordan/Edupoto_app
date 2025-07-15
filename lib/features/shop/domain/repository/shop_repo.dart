import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/data/api/woocommerce_api_client.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopRepo {
  final WoocommerceApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ShopRepo({required this.apiClient, required this.sharedPreferences});

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

  Future<Response> getOrderListApi() async {
    return await apiClient.getOrderData(AppConstants.getOrder);
  }

  Future<Response> createOrder(
      {required String currency,
      required String shippingTotal,
      required String total,
      required int customerId,
      required String paymentMethod,
      required String paymentMethodTitle,
      required String createdVia,
      required String customerNote}) async {
    return apiClient.postData(AppConstants.getOrder, {
      "currency": currency,
      "shipping_total": shippingTotal,
      "total": total,
      "customer_id": customerId,
      "payment_method": paymentMethod,
      "payment_method_title": paymentMethodTitle,
      "created_via": createdVia,
      "customer_note": customerNote
    });
  }

  Future<Response> getCustomerDataApi() async {
    return await apiClient.getCustomerData(AppConstants.getCustomer);
  }

  Future<Response> createCustomer({required String email}) async {
    return await apiClient.postData(AppConstants.getCustomer, {'email': email});
  }

  Future<void> setCustomerId(String customerId) async {
    try {
      await sharedPreferences.setString(AppConstants.customerId, customerId);
    } catch (e) {
      rethrow;
    }
  }

  void removeCustomerId() => sharedPreferences.remove(AppConstants.customerId);

  String getCustomerId() {
    return sharedPreferences.getString(AppConstants.customerId) ?? '';
  }
}
