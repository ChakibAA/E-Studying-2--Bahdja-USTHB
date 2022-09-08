// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:estudying2/models/course_model.dart';
import 'constant.dart';

class LocalStorage {
  late SharedPreferences prefs;
  String dataToMap(CourseModel data) => json.encode(data.toJson());
  CourseModel courseFromMap(String str) =>
      CourseModel.fromLocal(json.decode(str));

  Future setThemeMode(bool dark) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool(darkThemeURL, dark);
  }

  Future<bool?> getThemeMode() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool(darkThemeURL);
  }

  Future<bool> addFavCourse(CourseModel data) async {
    prefs = await SharedPreferences.getInstance();

    List<String>? favCourses;

    favCourses = prefs.getStringList(favLocalURL);

    String dataString = dataToMap(data);

    if (favCourses != null && favCourses.contains(dataString)) {
      return true;
    }

    favCourses ??= [];

    favCourses.add(dataString);

    await prefs.setStringList(favLocalURL, favCourses);
    return true;
  }

  Future<bool> deleteFavCourse(CourseModel data) async {
    prefs = await SharedPreferences.getInstance();

    List<String>? favCourses;

    favCourses = prefs.getStringList(favLocalURL);

    String dataString = dataToMap(data);

    if (favCourses == null || !favCourses.contains(dataString)) {
      return false;
    }
    favCourses.remove(dataToMap(data));

    await prefs.setStringList(favLocalURL, favCourses);
    return true;
  }

  Future<bool> coursIsLiked(CourseModel data) async {
    prefs = await SharedPreferences.getInstance();

    List<String>? favCourses;

    favCourses = prefs.getStringList(favLocalURL);

    String dataString = dataToMap(data);

    if (favCourses != null && favCourses.contains(dataString)) {
      return true;
    }

    return false;
  }

  Future<List<CourseModel>?> getFavCourses() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? dataBrut;
    List<CourseModel> data = [];

    dataBrut = prefs.getStringList(favLocalURL);

    if (dataBrut != null) {
      for (var element in dataBrut) {
        data.add(courseFromMap(element));
      }
    }
    return data;
  }
}
