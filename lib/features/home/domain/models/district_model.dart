import 'package:hosomobile/features/home/domain/models/all_school_model.dart';

class Districts {
  final int? id;
  final String? name;
  final List<AllSchoolModel> schools;
  final SchoolPagination? schoolsPagination;

  Districts({
    this.id,
    this.name,
    required this.schools,
    this.schoolsPagination,
  });

  factory Districts.fromJson(Map<String, dynamic> json) => Districts(
        id: json['id'],
        name: json['district_name'],
        schools: (json['schools'] as List?)
                ?.map((v) => AllSchoolModel.fromJson(v))
                .toList() ??
            [],
        schoolsPagination: json['schools_pagination'] != null
            ? SchoolPagination.fromJson(json['schools_pagination'])
            : null,
      );
}

class SchoolPagination {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;

  SchoolPagination({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
  });

  factory SchoolPagination.fromJson(Map<String, dynamic> json) => SchoolPagination(
        total: json['total'],
        perPage: json['per_page'],
        currentPage: json['current_page'],
        lastPage: json['last_page'],
      );

  bool get hasMore => currentPage < lastPage;
}