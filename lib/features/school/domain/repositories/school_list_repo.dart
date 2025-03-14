
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class SchoolListRepo{
  final ApiClient apiClient;

  SchoolListRepo({required this.apiClient});

  Future<Response> getSchoolList(int offset) async {
    return await apiClient.getData('${AppConstants.schoolList}?limit=1000&offset=$offset');
  }
}