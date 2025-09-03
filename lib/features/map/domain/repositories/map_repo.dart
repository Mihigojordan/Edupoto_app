
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/data/api/map_api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class MapRep{
  final MapApiClient apiClient;

  MapRep({required this.apiClient});

  Future<Response> getSchoolList(int offset, int schoolId) async {
    return await apiClient.getMapData('?input=kigali&types=address&key=AIzaSyBjO0TDpvkwkhs0ej-VcZw-9FT_Lm-MOn0&sessiontoken=52390e9e-3afb-4de5-959b-90b06fde9364&language=en-us&components=country%3Arw');
  }
}