import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/features/home/domain/models/banner_model.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/domain/reposotories/bilboard_repo.dart';

class BilboardController extends GetxController implements GetxService {
  final BilboardRepo bilboardRepo;
  BilboardController({required this.bilboardRepo});


  List<BannerModel>? _bannerList;
  int _bannerActiveIndex = 0;

  List<BannerModel>? get bannerList => _bannerList;
  int get bannerActiveIndex => _bannerActiveIndex;


  Future getBilboardList(bool reload, {bool isUpdate = true,required int type})async{
  
    if(_bannerList == null || reload) {
      _bannerList = null;
      if (isUpdate) {
        update();
      }
    }
    if (_bannerList == null) {
      Response response = await bilboardRepo.getBilboardList(type);
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