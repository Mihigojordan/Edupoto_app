class StudentModel {

  String? name;
  int?id;
  String? code;
  int? schoolId;
  int? classId;
  String? parent1;
  int? parent2;
  String? school;
  String? studentClass;


  StudentModel(
      {
        this.id,
        this.name,
        this.code,
        this.schoolId,
        this.classId,
        this.parent1,this.parent2,this.school,this.studentClass});

  StudentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    code = json['code'];
    schoolId = json['school_id'];
    classId = json['class_id'];
    parent1 = json['parent_id'];
    parent2 = json['parent_id2'];
    school = json['school_name'];
    studentClass = json['class_name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['code'] = code;
    data['referral_school_id'] = schoolId;
    data['referral_class_id'] = classId;
    data['parent_id'] = parent1;
    data['parent_id2'] = parent2;
    data['school_name'] = school;
    data['class_name'] = studentClass;
   
    return data;
  }
}
