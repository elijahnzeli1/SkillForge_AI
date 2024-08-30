import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:logging/logging.dart';

class OfflineService {
  final Logger _logger = Logger('OfflineService');
  static const String _offlineCoursesKey = 'offline_courses';

  Future<void> saveCourseOffline(Course course) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<Course> existingCourses = await getOfflineCourses();
      existingCourses.add(course);

      List<Map<String, dynamic>> coursesMap = existingCourses
          .map((c) => c.toJson())
          .cast<Map<String, dynamic>>()
          .toList();
      String coursesJson = json.encode(coursesMap);

      await prefs.setString(_offlineCoursesKey, coursesJson);

      _logger.info('Course data saved offline successfully');
    } catch (e) {
      _logger.severe('Failed to save course data offline', e);
    }
  }

  Future<void> removeCourseOffline(String courseId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<Course> existingCourses = await getOfflineCourses();
      existingCourses.removeWhere((course) => course.id == courseId);

      List<Map<String, dynamic>> coursesMap = existingCourses
          .map((c) => c.toJson())
          .cast<Map<String, dynamic>>()
          .toList();
      String coursesJson = json.encode(coursesMap);

      await prefs.setString(_offlineCoursesKey, coursesJson);

      _logger.info('Course data removed offline successfully');
    } catch (e) {
      _logger.severe('Failed to remove course data offline', e);
    }
  }

  Future<List<Course>> getOfflineCourses() async {
    // Implementation of getOfflineCourses method
    return [];
  }
}

class Course {
  late String id;
  // Assuming the Course class has a toJson method
  Map<String, dynamic> toJson() {
    // Convert the course object to a JSON map
    // Implementation details depend on the Course class structure
    return {'id': id};
  }
}
