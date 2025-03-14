class Districts {
  int? id;
  String? name;
  List<AllSchoolModel> schools; // Ensuring it is always a list

  Districts({this.id, this.name, List<AllSchoolModel>? schools})
      : schools = schools ?? []; // Ensuring non-null list

  Districts.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['district_name'],
        schools = (json['schools'] as List?)
                ?.map((v) => AllSchoolModel.fromJson(v))
                .toList() ??
            []; // Safe list initialization

  Map<String, dynamic> toJson() => {
        'id': id,
        'district_name': name,
        'schools': schools.map((v) => v.toJson()).toList(),
      };
}

class AllSchoolModel {
  int? id;
  String? schoolName;
  String? countryCode;
  String? address;
  String? phone;
  List<ClassDetails> classes; // Ensuring non-null list

  AllSchoolModel({
    this.id,
    this.schoolName,
    this.countryCode,
    this.address,
    this.phone,
    List<ClassDetails>? classes,
  }) : classes = classes ?? []; // Ensuring non-null list

  AllSchoolModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        address = json['address'],
        countryCode = json['countryCode'],
        phone = json['phone'],
        schoolName = json['school_name'],
        classes = (json['classes'] as List?)
                ?.map((v) => ClassDetails.fromJson(v))
                .toList() ??
            []; // Safe list initialization

  Map<String, dynamic> toJson() => {
        'id': id,
        'school_name': schoolName,
        'address': address,
        'countryCode': countryCode,
        'phone': phone,
        'classes': classes.map((v) => v.toJson()).toList(),
      };
}

class ClassDetails {
  int? id;
  String? className;
  List<Student> students; // Ensuring non-null list

  ClassDetails({this.id, this.className, List<Student>? students})
      : students = students ?? []; // Ensuring non-null list

  ClassDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        className = json['class_name'],
        students = (json['students'] as List?)
                ?.map((v) => Student.fromJson(v))
                .toList() ??
            []; // Safe list initialization

  Map<String, dynamic> toJson() => {
        'id': id,
        'class_name': className,
        'students': students.map((v) => v.toJson()).toList(),
      };
}

class Student {
  int? id;
  String? name;
  String? code;

  Student({this.id, this.name, this.code});

  Student.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        code = json['code'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'code': code,
      };
}
