
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/data/api/api_checker.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/shop/domain/models/attribute_model.dart';
import 'package:hosomobile/features/shop/domain/models/category_model.dart';
import 'package:hosomobile/features/shop/domain/models/brand_model.dart';
import 'package:hosomobile/features/shop/domain/models/customer_model.dart';
import 'package:hosomobile/features/shop/domain/models/order_model.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
import 'package:hosomobile/features/shop/domain/repository/shop_repo.dart';

class ShopController extends GetxController implements GetxService{
  final ShopRepo shopRepo;
  ShopController({required this.shopRepo});
  bool _isLoading = false;
  List<Product>? _shopList;
  List<WooCategory>? _categoryList;
  List<BrandModel>? _brandList;
  List<AttributeModel>? _attributeList;
  List<OrderModel>? _orderList;

  CustomerModel? _customerInfo;
 

  CustomerModel? get userInfo => _customerInfo;
  

  bool get isLoading => _isLoading;
  List<Product>? get shopList => _shopList;
  List<WooCategory>? get categoryList => _categoryList;
  List<BrandModel>? get brandList => _brandList;
  List<AttributeModel>? get attributeList => _attributeList;
  List<OrderModel>? get orderList => _orderList;

  Future getShopList(bool reload , {bool isUpdate = true}) async {
    if(_shopList == null || reload) {
      _shopList = null;
      _isLoading = true;

      if(isUpdate){
        update();
      }
    }
    if(_shopList == null ) {
      _shopList = [];
      Response response = await shopRepo.getProductListApi();
      print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${response.body}');
      if(response.body != null && response.body != {} && response.statusCode == 200){
        _shopList = [];
        response.body.forEach((website) {_shopList!.add(Product.fromJson(website));});
      }else{
        _shopList = [];
        ApiChecker.checkApi(response);

      }

      _isLoading = false;
      update();

    }
  }

  Future getCategoryList(bool reload , {bool isUpdate = true}) async {
    if(_categoryList == null || reload) {
      _categoryList = null;
      _isLoading = true;

      if(isUpdate){
        update();
      }
    }
    if(_categoryList == null ) {
      _categoryList = [];
      Response response = await shopRepo.getCategoryListApi();
      print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${response.body}');
      if(response.body != null && response.body != {} && response.statusCode == 200){
        _categoryList = [];
        response.body.forEach((website) {_categoryList!.add(WooCategory.fromJson(website));});
      }else{
        _categoryList = [];
        ApiChecker.checkApi(response);

      }

      _isLoading = false;
      update();

    }
  }

 Future getBrandList(bool reload , {bool isUpdate = true}) async {
    if(_brandList == null || reload) {
      _brandList = null;
      _isLoading = true;

      if(isUpdate){
        update();
      }
    }
    if(_brandList == null ) {
      _brandList = [];
      Response response = await shopRepo.getBrandListApi();
      print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${response.body}');
      if(response.body != null && response.body != {} && response.statusCode == 200){
        _brandList = [];
        response.body.forEach((website) {_brandList!.add(BrandModel.fromJson(website));});
      }else{
        _brandList = [];
        ApiChecker.checkApi(response);

      }

      _isLoading = false;
      update();

    }
  }

   Future getAttributeList(bool reload , {bool isUpdate = true}) async {
    if(_attributeList == null || reload) {
      _attributeList = null;
      _isLoading = true;

      if(isUpdate){
        update();
      }
    }
    if(_attributeList == null ) {
      _attributeList = [];
      Response response = await shopRepo.getAttributeListApi();
      
      if(response.body != null && response.body != {} && response.statusCode == 200){
        _attributeList = [];
        response.body.forEach((website) {_attributeList!.add(AttributeModel.fromJson(website));});
      
      }else{
        _attributeList = [];
        ApiChecker.checkApi(response);

      }

      _isLoading = false;
      update();

    }
  }

   Future getOrderList(bool reload , {bool isUpdate = true}) async {
    if(_orderList == null || reload) {
      _orderList = null;
      _isLoading = true;

      if(isUpdate){
        update();
      }
    }
    if(_orderList == null ) {
      _orderList = [];
      Response response = await shopRepo.getOrderListApi();
      
      if(response.body != null && response.body != {} && response.statusCode == 200){
        _orderList = [];
         print('++++++++++++++++++++++++++++++++++++++++ order lists $_orderList'); 
        response.body.forEach((website) {_orderList!.add(OrderModel.fromJson(website));});
       
      
      }else{
        _orderList = [];
        ApiChecker.checkApi(response);

      }

      _isLoading = false;
      update();

    }
  }

    Future<Response> createOrder({required String currency, required String shippingTotal, required String total, required int customerId,required String paymentMethod, required String paymentMethodTitle,required String createdVia, required String customerNote}) async{

    _isLoading = true;
    update();

    Response response = await shopRepo.createOrder(currency: currency, shippingTotal: shippingTotal, total: total, customerId: customerId, paymentMethod: paymentMethod, paymentMethodTitle: paymentMethodTitle, createdVia: createdVia, customerNote: customerNote);
    if(response.statusCode==201){
        _isLoading = false;

   }else{
     _isLoading = false;
     ApiChecker.checkApi(response);
   }
   update();
   return response;
  }

   Future<void> getCustomerData({bool reload = false, bool isUpdate = false}) async {
    if(reload || _customerInfo == null) {
      _customerInfo = null;
      _isLoading = true;
      if(isUpdate) {
        update();
      }
    }

    if(_customerInfo == null) {
      Response response = await shopRepo.getCustomerDataApi();
      if (response.statusCode == 200) {
        _customerInfo = CustomerModel.fromJson(response.body);

      } else {
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    }

  }

   Future<Response> customerReg(String email) async{
      _isLoading = true;
      update();

      Response response = await shopRepo.createCustomer(email: email);

      if (response.statusCode == 200) {


        // Get.offAllNamed(RouteHelper.getWelcomeRoute(
        //   countryCode: signUpBody.dialCountryCode,phoneNumber: signUpBody.phone,
        //   password: signUpBody.password,
        // ));
    // ************************ remove the delay after registration******************
            // Get.offAllNamed(RouteHelper.getRestart());
       //Set Parent Id for the child
       shopRepo.setCustomerId(response.body['id'].toString());

      } else {
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
      return response;
  }

}