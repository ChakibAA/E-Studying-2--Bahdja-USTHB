class CourseModel {
  int? iD;
  String? title;
  String? courseFile;
  String? courseType;
  bool? fav;

  CourseModel(
      {this.iD, this.title, this.courseFile, this.courseType, this.fav});

  CourseModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    title = json['post_title'];
    courseFile = json['course_file'] is String ? json['course_file'] : null;
    courseType = json['course_type'];
    fav = json['fav'];
  }
  CourseModel.fromLocal(Map<String, dynamic> json) {
    iD = json['ID'];
    title = json['post_title'];
    courseFile = json['course_file'];
    courseType = json['course_type'];
    fav = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;

    data['post_title'] = title;
    data['course_file'] = courseFile;
    data['course_type'] = courseType;
    return data;
  }
}
