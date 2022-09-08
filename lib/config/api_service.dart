// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:estudying2/models/course_model.dart';
import 'package:estudying2/models/speciality_model.dart';
import '../models/faculty_model.dart';
import '../models/module_model.dart';
import 'constant.dart';

class ApiService {
  final Dio dio = Dio(BaseOptions(
      // connectTimeout: 5000,
      // receiveTimeout: 3000,
      ));

  Future<List<SpecialityModel>?> fetchSpeciality(String faculty) async {
    List<SpecialityModel>? data;
    String url = '$getSpecialityURL?faculty=$faculty';

    Response response = await dio.get(
      url,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      data = (response.data as List)
          .map(
            (i) => SpecialityModel.fromJson(i),
          )
          .toList();
    }
    return data;
  }

  Future<List<FacultyModel>?> fetchFaculty() async {
    List<FacultyModel>? data;
    Response response = await dio.get(
      getFacultyURL,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      data = (response.data as List)
          .map(
            (i) => FacultyModel.fromJson(i),
          )
          .toList();
    }
    return data;
  }

  Future<List<CourseModel>?> fetchCourses(
      String moduleID, String type, String page) async {
    List<CourseModel>? data;

    Response response = await dio.get(
      '$getCoursesURL?module=$moduleID&course_type=$type&page=$page',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      data = (response.data as List)
          .map(
            (i) => CourseModel.fromJson(i),
          )
          .toList();
    }
    return data;
  }

  Future<List<ModuleModel>?> fetchModule(String specialityID, String semesterID,
      {String page = "0"}) async {
    List<ModuleModel>? data;
    Response response = await dio.get(
      '$getModulesURL?speciality=$specialityID&semester=$semesterID',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      data = (response.data as List)
          .map(
            (i) => ModuleModel.fromJson(i),
          )
          .toList();
    }

    return data;
  }
}
