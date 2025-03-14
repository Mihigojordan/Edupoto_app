import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class EduboxMaterialRepo{
  final ApiClient apiClient;

  EduboxMaterialRepo({required this.apiClient});

  Future<Response> getEduboxMaterialListApi({required int schoolId,required int classId,required int studentId}) async {

    return await apiClient.getData('${AppConstants.eduboxMaterial}/$schoolId/$classId/$studentId');
  }
}