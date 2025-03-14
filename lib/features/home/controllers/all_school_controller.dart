import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/domain/reposotories/all_school_repo.dart';
import 'package:get/get.dart';

class AllSchoolController extends GetxController {
  final AllSchoolRepo allSchoolRepo;
  AllSchoolController({required this.allSchoolRepo});

  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  List<Districts> _schoolList = [];

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  List<Districts> get schoolList => _schoolList;

  Future<List<Districts>> getSchoolList(bool reload) async {
    if (reload) {
      _schoolList = [];
      _currentPage = 1;
      _hasMore = true;
      _isLoading = true;
      update();
    }

    if (!_hasMore || _isLoading) return _schoolList;

    _isLoading = true;
    update();

    Response response = await allSchoolRepo.getAllSchoolListApi(page: _currentPage);

    if (response.statusCode == 200 && response.body != null) {
      List newSchools = response.body['districts'];
      if (newSchools.isNotEmpty) {
        _schoolList.addAll(newSchools.map((s) => Districts.fromJson(s)));
        _currentPage++;
      } else {
        _hasMore = false; // Stop pagination when no more data
      }
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    update();

    return _schoolList;
  }

  
}