// Package imports:
import 'package:azlistview/azlistview.dart';

// Project imports:
import 'faculty_model.dart';

class SpecialityModel extends ISuspensionBean {
  String? id;
  String? title;
  String? schoolYear;
  FacultyModel? faculty;
  String? tag;

  @override
  String getSuspensionTag() => tag!;

  SpecialityModel(
      {this.id, this.title, this.schoolYear, this.faculty, this.tag});

  SpecialityModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'].toString();
    title = json['post_title'].toString().toUpperCase();

    schoolYear = json['school_year'];
    faculty =
        json['faculty'] != null ? FacultyModel.fromJson(json['faculty']) : null;

    tag = title![0].toUpperCase();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['post_title'] = title;

    data['school_year'] = schoolYear;
    if (faculty != null) {
      data['faculty'] = faculty!.toJson();
    }
    return data;
  }
}
