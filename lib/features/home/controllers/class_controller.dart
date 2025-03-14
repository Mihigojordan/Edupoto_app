
import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/features/home/domain/models/class_model.dart';
import 'package:hosomobile/features/home/domain/reposotories/class_repo.dart';
import 'package:get/get.dart';

class ClassController extends GetxController implements GetxService{
  final ClassRepo classRepo;
  ClassController({required this.classRepo});
  bool _isLoading = false;
  List<ClassModel>? _classList;

  bool get isLoading => _isLoading;
  List<ClassModel>? get classList => _classList;

  Future getClasList(bool reload , {bool isUpdate = true}) async {
    if(_classList == null || reload) {
      _classList = null;
      _isLoading = true;

      if(isUpdate){
        update();
      }
    }
    if(_classList == null ) {
      _classList = [];
      Response response = await classRepo.getClassListApi();
      if(response.body != null && response.body != {} && response.statusCode == 200){
        _classList = [];
        response.body.forEach((website) {_classList!.add(ClassModel.fromJson(website));});
      }else{
        _classList = [];
        ApiChecker.checkApi(response);

      }

      _isLoading = false;
      update();

    }
  }


}