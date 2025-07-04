
import 'package:hosomobile/data/api/api_checker.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
import 'package:hosomobile/features/shop/domain/repository/shop_repo.dart';

class ShopController extends GetxController implements GetxService{
  final ShopRepo shopRepo;
  ShopController({required this.shopRepo});
  bool _isLoading = false;
  List<ShopModel>? _shopList;

  bool get isLoading => _isLoading;
  List<ShopModel>? get shopList => _shopList;

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
      Response response = await shopRepo.getShopListApi();
      print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${response.body}');
      if(response.body != null && response.body != {} && response.statusCode == 200){
        _shopList = [];
        response.body.forEach((website) {_shopList!.add(ShopModel.fromJson(website));});
      }else{
        _shopList = [];
        ApiChecker.checkApi(response);

      }

      _isLoading = false;
      update();

    }
  }


}