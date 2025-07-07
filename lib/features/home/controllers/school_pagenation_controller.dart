import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hosomobile/features/home/domain/models/district_model.dart';
import 'package:hosomobile/features/home/domain/reposotories/all_school_repo.dart';

class SchoolPaginationController extends GetxController {
  final AllSchoolRepo allSchoolRepo;
  SchoolPaginationController({required this.allSchoolRepo});

  // District-level pagination
  final RxInt currentDistrictPage = 1.obs;
  final RxBool hasMoreDistricts = true.obs;
  
  // School-level pagination (per district)
  final Map<int, int> schoolPages = {}; // districtId -> currentPage
  final Map<int, bool> hasMoreSchools = {}; // districtId -> hasMore

  Future<void> loadMoreDistricts() async {
    if (!hasMoreDistricts.value) return;
    
    final response = await allSchoolRepo.getAllSchoolListApi(
      page: currentDistrictPage.value,
    );
    
    if (response.statusCode == 200) {
      final newDistricts = response.body['districts'] as List;
      
      if (newDistricts.isEmpty) {
        hasMoreDistricts.value = false;
      } else {
        currentDistrictPage.value++;
      }
    }
  }

  Future<void> loadMoreSchools(int districtId) async {
    if (hasMoreSchools[districtId] == false) return;
    
    final currentPage = (schoolPages[districtId] ?? 0) + 1;
    final response = await allSchoolRepo.getSchoolsForDistrict(
      districtId: districtId,
      page: currentPage,
    );
    
    if (response.statusCode == 200) {
      final pagination = SchoolPagination.fromJson(response.body['pagination']);
      schoolPages[districtId] = currentPage;
      hasMoreSchools[districtId] = pagination.hasMore;
    }
  }
}