import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class SchoolRepo{
  final ApiClient apiClient;

  SchoolRepo({required this.apiClient});

  Future<Response> getSchoolListApi() async {
    return await apiClient.getData(AppConstants.school);
  }
}