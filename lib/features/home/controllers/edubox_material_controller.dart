
import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/home/domain/reposotories/edubox_material_repo.dart';
import 'package:get/get.dart';

class EduboxMaterialController extends GetxController implements GetxService{
  final EduboxMaterialRepo eduboxMaterialRepo;
  EduboxMaterialController({required this.eduboxMaterialRepo});
  bool _isLoading = false;
 
  List<EduboxProductModel>? _eduboxMaterialList;
 

  bool get isLoading => _isLoading;
  List<EduboxProductModel>? get eduboxMaterialList => _eduboxMaterialList;

  Future getEduboxMaterialList(bool reload , {bool isUpdate = true,required int schoolId,required int classId,required int studentId }) async {
    if(_eduboxMaterialList == null || reload) {
      _eduboxMaterialList = null;
      _isLoading = true;
     
      if(isUpdate){
        update();
       
      }
    }
    if(_eduboxMaterialList == null ) {
      _eduboxMaterialList = [];
      
      Response response = await eduboxMaterialRepo.getEduboxMaterialListApi(schoolId:schoolId, classId: classId,studentId: studentId);
      print('++++++++++++++++++++++++++++++Edubox Material: ${response.statusCode}/${response.body}');
      if(response.body != null && response.body != {} && response.statusCode == 200){
        _eduboxMaterialList = [];
        response.body['products'].forEach((website) {_eduboxMaterialList!.add(EduboxProductModel.fromJson(website));});
      }else{
        _eduboxMaterialList = [];
        ApiChecker.checkApi(response);

      }

      _isLoading = false;
      update();

    }
  }


}