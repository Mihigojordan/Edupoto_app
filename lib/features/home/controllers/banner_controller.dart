import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/features/home/domain/models/banner_model.dart';
import 'package:hosomobile/features/home/domain/reposotories/banner_repo.dart';
import 'package:get/get.dart';

class BannerController extends GetxController implements GetxService {
  final BannerRepo bannerRepo;
  BannerController({required this.bannerRepo});


  List<BannerModel>? _bannerList;
  int _bannerActiveIndex = 0;

  List<BannerModel>? get bannerList => _bannerList;
  int get bannerActiveIndex => _bannerActiveIndex;


  Future getBannerList(bool reload, {bool isUpdate = true,required int type})async{
  
    if(_bannerList == null || reload) {
      _bannerList = null;
      if (isUpdate) {
        update();
      }
    }
    if (_bannerList == null) {
      Response response = await bannerRepo.getBannerList(type);
      if (response.statusCode == 200) {
        _bannerList = [];
      
        response.body.forEach((banner) {

          _bannerList!.add(BannerModel.fromJson(banner));
        });
      } else {
        _bannerList = [];
        ApiChecker.checkApi(response);
      }
      update();
    }
  }


  void updateBannerActiveIndex(int index) {
    _bannerActiveIndex = index;
    update();
  }
}