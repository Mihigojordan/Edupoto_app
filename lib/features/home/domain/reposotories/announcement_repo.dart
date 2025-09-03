import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class AnnouncementRepo{
  final ApiClient apiClient;

  AnnouncementRepo({required this.apiClient});

  Future<Response> getAnnouncementListApi() async {
    return await apiClient.getData(AppConstants.announcement);
  }
}