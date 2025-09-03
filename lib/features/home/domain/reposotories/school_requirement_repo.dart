import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class SchoolRequirementRepo{
  final ApiClient apiClient;

  SchoolRequirementRepo({required this.apiClient});

  Future<Response> getSchoolRequirementListApi({required int schoolId,required int classId, required int studentId}) async {
    return await apiClient.getData('${AppConstants.schoolRequirement}/$schoolId/$classId/$studentId');
  }
}