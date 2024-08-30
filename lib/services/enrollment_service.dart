import 'package:flutter/material.dart';

class EnrollmentService with ChangeNotifier {
  Future<void> enrollInCourse(String userId, String courseId) async {
    // Simulate a network call to enroll in a course

    await Future.delayed(const Duration(seconds: 2));

    // Assume the enrollment is successful

    notifyListeners();
  }
}
