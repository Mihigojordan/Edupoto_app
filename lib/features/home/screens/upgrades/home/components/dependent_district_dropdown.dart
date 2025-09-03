import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';

class DependentDistrictDropdowns extends StatefulWidget {
  const DependentDistrictDropdowns({super.key});

  @override
  _SearchableListState createState() => _SearchableListState();
}

class _SearchableListState extends State<DependentDistrictDropdowns> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _districtSearchController = TextEditingController();
  final TextEditingController _schoolSearchController = TextEditingController();
  List<Districts> _filteredDistricts = [];
  Districts? _selectedDistrict;
  List<AllSchoolModel> _filteredSchools = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
    _districtSearchController.addListener(_filterDistricts);
    _schoolSearchController.addListener(_filterSchools);
  }

  void _loadMore() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      Get.find<AllSchoolController>().getSchoolList(false);
    }
  }

  void _filterDistricts() {
    final query = _districtSearchController.text.toLowerCase();
    setState(() {
      _filteredDistricts = Get.find<AllSchoolController>()
          .schoolList
          .where((district) => district.name!.toLowerCase().contains(query))
          .toList();
    });
  }

  void _filterSchools() {
    final query = _schoolSearchController.text.toLowerCase();
    setState(() {
      if (_selectedDistrict != null) {
        // Search across all schools in the selected district
        _filteredSchools = _selectedDistrict!.schools
            .where((school) => school.schoolName!.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _toggleDistrictSelection(Districts district) {
    setState(() {
      if (_selectedDistrict == district) {
        _selectedDistrict = null; // Collapse if already selected
        _schoolSearchController.clear(); // Clear school search when collapsing
      } else {
        _selectedDistrict = district; // Expand the selected district
        _filteredSchools = district.schools; // Initialize filtered schools with all schools
      }
    });
  }

  @override
  void dispose() {
    _districtSearchController.dispose();
    _schoolSearchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllSchoolController>(builder: (allSchoolController) {
      // Initialize filtered list if empty
      if (_filteredDistricts.isEmpty) {
        _filteredDistricts = allSchoolController.schoolList;
      }

      return SizedBox(
        height: 500,
        child: Column(
          children: [
            // District Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _districtSearchController,
                decoration: InputDecoration(
                  hintText: 'Search districts...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
            // School Search Bar (Visible only when a district is selected)
            if (_selectedDistrict != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _schoolSearchController,
                  decoration: InputDecoration(
                    hintText: 'Search all schools in ${_selectedDistrict!.name}...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
            // List of Districts and Schools
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _filteredDistricts.length + 1,
                itemBuilder: (context, index) {
                  if (index < _filteredDistricts.length) {
                    final district = _filteredDistricts[index];
                    return Column(
                      children: [
                        // District Container
                        GestureDetector(
                          onTap: () => _toggleDistrictSelection(district),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  district.name ?? 'No Name',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Icon(
                                  _selectedDistrict == district
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                ),
                              ],
                            ),
                          ),
                        ),
        
                        // Schools in the Selected District
                        if (_selectedDistrict == district)
                          ..._filteredSchools.map((school) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 16, right: 8),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  school.schoolName ?? 'No School Name',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                      ],
                    );
                  } else {
                    return 
                    // allSchoolController.isLoading
                    //     ? const Center(child: CircularProgressIndicator())
                    //     : 
                        const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}