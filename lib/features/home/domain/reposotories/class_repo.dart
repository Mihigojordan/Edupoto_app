import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class ClassRepo{
  final ApiClient apiClient;

  ClassRepo({required this.apiClient});

  Future<Response> getClassListApi() async {
    return await apiClient.getData(AppConstants.studentClass);
  }
}