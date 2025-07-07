import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class AllSchoolRepo {
  final ApiClient apiClient;

  AllSchoolRepo({required this.apiClient});

  Future<Response> getAllSchoolListApi({int page = 1}) async {
    return await apiClient.getData('${AppConstants.allSchool}?page=$page');
  }

  Future<Response> getSchoolsForDistrict({
    required int districtId,
    int page = 1,
  }) async {
    return await apiClient.getData(
      '${AppConstants.allSchool}?district_id=$districtId&school_page=$page'
    );
  }
}
