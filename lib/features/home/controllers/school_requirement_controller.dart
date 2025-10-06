
import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/features/home/domain/models/school_requirement_model.dart';
import 'package:hosomobile/features/home/domain/reposotories/school_requirement_repo.dart';
import 'package:get/get.dart';

class SchoolRequirementController extends GetxController implements GetxService{
  final SchoolRequirementRepo schoolRequirementRepo;
  SchoolRequirementController({required this.schoolRequirementRepo});
  bool _isLoading = false;
  List<ProductTypeModel>? _schoolRequirementList;

  bool get isLoading => _isLoading;
  List<ProductTypeModel>? get schoolRequirementList => _schoolRequirementList;

  Future getSchoolRequirementList(bool reload , {bool isUpdate = true,required int schoolId,required int classId,required int studentId}) async {
    if(_schoolRequirementList == null || reload) {
      _schoolRequirementList = null;
      _isLoading = true;

      if(isUpdate){
        update();
      }
    }
    if(_schoolRequirementList == null ) {
      _schoolRequirementList = [];
      Response response = await schoolRequirementRepo.getSchoolRequirementListApi(schoolId: schoolId,classId: classId,studentId: studentId);
<<<<<<< HEAD
      print('wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww: school requirement: ${response.body}');
=======
      // print('wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww: school requirement: ${response.body}');
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
      if(response.body != null && response.body != {} && response.statusCode == 200){
        _schoolRequirementList = [];
        response.body['product_types'].forEach((website) {_schoolRequirementList!.add(ProductTypeModel.fromJson(website));});
      }else{
        _schoolRequirementList = [];
        ApiChecker.checkApi(response);

      }

      _isLoading = false;
      update();

    }
  }


}