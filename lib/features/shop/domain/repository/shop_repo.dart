import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/data/api/woocommerce_api_client.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
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
      required String customerNote,
      required String homePhone,
      required String shippingFirstName,
      required String shippingLastName,
      required String shippingCompany,
      required String shippingAddress1,
      required String shippingAddress2,
      required String shippingCity,
      required String shippingCountry,
      required List<Map<String,dynamic>> products,
      required String feeName,
      required String feeAmount
      }) async {
    return apiClient.postData(AppConstants.getOrder, {
      "currency": currency,
    "shipping":{
        "first_name":shippingFirstName,
        "last_name": shippingLastName,
        "company": shippingCompany,
        "address_1": shippingAddress1,
        "address_2": shippingAddress2,
        "city":shippingCity,
        "country": shippingCountry,
        "phone": homePhone
    },
    "customer_note":customerNote,
    "line_items":products,
    "shipping_lines":[
        {
            "method_id":1,
            "total":shippingTotal
        }
    ],
    "fee_lines":[
        {
            "name":feeName,
            "total":feeAmount
        }
    ],

      "total": total,
      "customer_id": customerId,
      "payment_method": paymentMethod,
      "payment_method_title": paymentMethodTitle,
      "created_via": createdVia,  
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
