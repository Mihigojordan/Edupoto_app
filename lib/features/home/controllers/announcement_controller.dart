
import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/features/home/domain/models/announcement_model.dart';
import 'package:hosomobile/features/home/domain/reposotories/announcement_repo.dart';
import 'package:get/get.dart';

class AnnouncementController extends GetxController implements GetxService{
  final AnnouncementRepo announcementRepo;
  AnnouncementController({required this.announcementRepo});
  bool _isLoading = false;
  List<AnnouncementModel>? _announcementList;

  bool get isLoading => _isLoading;
  List<AnnouncementModel>? get announcementList => _announcementList;

  Future getAnnouncementList(bool reload , {bool isUpdate = true}) async {
    if(_announcementList == null || reload) {
      _announcementList = null;
      _isLoading = true;

      if(isUpdate){
        update();
      }
    }
    if(_announcementList == null ) {
      _announcementList = [];
      Response response = await announcementRepo.getAnnouncementListApi();
      if(response.body != null && response.body != {} && response.statusCode == 200){
        _announcementList = [];
        response.body.forEach((website) {_announcementList!.add(AnnouncementModel.fromJson(website));});
      }else{
        _announcementList = [];
        ApiChecker.checkApi(response);

      }

      _isLoading = false;
      update();

    }
  }


}