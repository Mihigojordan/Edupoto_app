
import 'dart:convert';

import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/data/api/api_checker.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/shop/domain/models/attribute_model.dart';
import 'package:hosomobile/features/shop/domain/models/category_model.dart';
import 'package:hosomobile/features/shop/domain/models/brand_model.dart';
import 'package:hosomobile/features/shop/domain/models/customer_model.dart';
import 'package:hosomobile/features/shop/domain/models/customer_short_data_model.dart';
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

    Future<Response> createOrder({required List<Map<String,dynamic>>products,required String feeName,required String feeAmount,required String shippingAddress1,required String shippingAddress2,required String shippingFirstName,required String shippingLastName,required String shippingCompany,required String shippingCity,required String shippingCountry, required String homePhone,  required String currency, required String shippingTotal, required String total, required int customerId,required String paymentMethod, required String paymentMethodTitle,required String createdVia, required String customerNote}) async{

    _isLoading = true;
    update();

    Response response = await shopRepo.createOrder( products: products,feeName: feeName,feeAmount:feeAmount , shippingAddress1: shippingAddress1,shippingAddress2: shippingAddress2,shippingFirstName: shippingFirstName,shippingLastName:shippingLastName, shippingCompany: shippingCompany,shippingCity: shippingCity,shippingCountry: shippingCountry,homePhone:homePhone,currency: currency, shippingTotal: shippingTotal, total: total, customerId: customerId, paymentMethod: paymentMethod, paymentMethodTitle: paymentMethodTitle, createdVia: createdVia, customerNote: customerNote);
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

   Future<Response> customerReg({required String email,required String phone,required String firstName,required String lastName} ) async{
      _isLoading = true;
      update();

      Response response = await shopRepo.createCustomer(email: email,phone: phone,firstName: firstName,lastName: lastName);

      if (response.statusCode == 201) {
        print('cusotmer id ${response.body['id'].toString()}');

       setCustomerData(CustomerShortDataModel(
          email: response.body['email'].toString(),
          phone: response.body['phone'].toString(),
          firstName: response.body['first_name'].toString(),
          lastName: response.body['last_name'].toString(),
        ));
       //Set Parent Id for the child
       shopRepo.setCustomerId(response.body['id'].toString());

      } else {
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
      return response;
  }

    Future<Response> updateCustomerInfo({ required int id, required String email,required String phone,required String firstName,required String lastName} ) async{
      _isLoading = true;
      update();

      Response response = await shopRepo.editCustomer(id:id, email: email,phone: phone,firstName: firstName,lastName: lastName);

      if (response.statusCode == 200) {
       

       setCustomerData(CustomerShortDataModel(
          email: response.body['email'].toString(),
          phone: response.body['phone'].toString(),
          firstName: response.body['first_name'].toString(),
          lastName: response.body['last_name'].toString(),
        ));
       //Set Parent Id for the child
       shopRepo.setCustomerId(response.body['id'].toString());

      } else {
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
      return response;
  }

    Future setCustomerData(CustomerShortDataModel customerData) async {
    await shopRepo.setCustomerData(customerData);
  }
  CustomerShortDataModel? getCustomerInfo(){
    CustomerShortDataModel? customerData;
    if(shopRepo.getCustomerData() != '') {
      customerData = CustomerShortDataModel.fromJson(jsonDecode(shopRepo.getCustomerData()));
    }
    return customerData;
  }

   Future setCustomerId(String customerId) async {
    await shopRepo.setCustomerId(customerId);
  }
 int? getCustomerId(){
    int? customerId;
    if(shopRepo.getCustomerId() != '') {
      customerId = int.parse(shopRepo.getCustomerId());
    }
    return customerId;
  }

  void removeUserId()=>  shopRepo.removeCustomerId();

}