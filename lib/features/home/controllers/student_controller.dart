
import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/features/home/domain/models/student_model.dart';
import 'package:hosomobile/features/home/domain/reposotories/student_repo.dart';

import 'package:get/get.dart';

class StudentController extends GetxController implements GetxService{
  final StudentRepo studentRepo;
  StudentController({required this.studentRepo});
  bool _isLoading = false;
  List<StudentModel>? _studentList;

  bool get isLoading => _isLoading;
  List<StudentModel>? get studentList => _studentList;

  Future getStudentList(bool reload , {bool isUpdate = true, required String id}) async {
    if(_studentList == null || reload) {
      _studentList = null;
      _isLoading = true;

      if(isUpdate){
        update();
      }
    }
    if(_studentList == null ) {
      _studentList = [];
      Response response = await studentRepo.getStudentListApi(id);

      print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Student: ${response.statusCode}');
      if(response.body != null && response.body != {} && response.statusCode == 200){
        _studentList = [];
        response.body.forEach((website) {_studentList!.add(StudentModel.fromJson(website));});
      }else{
        _studentList = [];
        ApiChecker.checkApi(response);

      }

      _isLoading = false;
      update();

    }
  }


}