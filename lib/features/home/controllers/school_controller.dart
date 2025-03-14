
import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/features/home/domain/models/school_model.dart';
import 'package:hosomobile/features/home/domain/reposotories/school_repo.dart';
import 'package:get/get.dart';

class SchoolController extends GetxController implements GetxService{
  final SchoolRepo schoolRepo;
  SchoolController({required this.schoolRepo});
  bool _isLoading = false;
  List<SchoolModel>? _schoolList;

  bool get isLoading => _isLoading;
  List<SchoolModel>? get schoolList => _schoolList;

  Future getSchoolList(bool reload , {bool isUpdate = true}) async {
    if(_schoolList == null || reload) {
      _schoolList = null;
      _isLoading = true;

      if(isUpdate){
        update();
      }
    }
    if(_schoolList == null ) {
      _schoolList = [];
      Response response = await schoolRepo.getSchoolListApi();
      if(response.body != null && response.body != {} && response.statusCode == 200){
        _schoolList = [];
        response.body.forEach((website) {_schoolList!.add(SchoolModel.fromJson(website));});
      }else{
        _schoolList = [];
        ApiChecker.checkApi(response);

      }

      _isLoading = false;
      update();

    }
  }


}