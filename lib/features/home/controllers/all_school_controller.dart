import 'package:flutter/material.dart';
import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/domain/reposotories/all_school_repo.dart';
import 'package:get/get.dart';

class AllSchoolController extends GetxController {
  final AllSchoolRepo allSchoolRepo;
  AllSchoolController({required this.allSchoolRepo});

  // Reactive state variables
  final RxInt _currentPage = 1.obs;
  final RxBool _isLoading = false.obs;
  final RxBool _hasMore = true.obs;
  final RxList<Districts> _schoolList = <Districts>[].obs;
  final RxBool _isInitialLoad = true.obs;
  final ScrollController scrollController = ScrollController();

  // Getters
  int get currentPage => _currentPage.value;
  bool get isLoading => _isLoading.value;
  bool get hasMore => _hasMore.value;
  List<Districts> get schoolList => _schoolList;
  bool get isInitialLoad => _isInitialLoad.value;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    loadInitialData();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >= 
        scrollController.position.maxScrollExtent * 0.8) {
      if (!_isLoading.value && _hasMore.value) {
        getSchoolList(false);
      }
    }
  }

  Future<void> loadInitialData() async {
    if (_schoolList.isEmpty) {
      await getSchoolList(true);
    }
  }

  Future<void> getSchoolList(bool reload) async {
    if (_isLoading.value || (!reload && !_hasMore.value)) return;

    if (reload) {
      _schoolList.clear();
      _currentPage.value = 1;
      _hasMore.value = true;
      _isInitialLoad.value = true;
    }

    _isLoading.value = true;

    try {
      final Response response = await allSchoolRepo.getAllSchoolListApi(
        page: _currentPage.value,
      );

      if (response.statusCode == 200 && response.body != null) {
        final newDistricts = (response.body['districts'] as List?) ?? [];
        final pagination = response.body['pagination'];
        
        if (newDistricts.isNotEmpty) {
          _schoolList.addAll(newDistricts.map((s) => Districts.fromJson(s)));
          _currentPage.value++;
          
          if (pagination != null) {
            _hasMore.value = pagination['current_page'] < pagination['last_page'];
          } else {
            _hasMore.value = newDistricts.length >= 10;
          }
        } else {
          _hasMore.value = false;
        }
        
        _isInitialLoad.value = false;
      } else {
        ApiChecker.checkApi(response);
        _hasMore.value = false;
      }
    } catch (e) {
<<<<<<< HEAD
      debugPrint('Error loading schools: $e');
=======
      // debugPrint('Error loading schools: $e');
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
      Get.snackbar('Error', 'Failed to load schools: ${e.toString()}');
      _hasMore.value = false;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await getSchoolList(true);
  }
}