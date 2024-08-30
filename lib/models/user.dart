import 'package:skillforge_ai/models/course.dart';

class User {
  final String id;
  final String name;
  final String email;
  List<Course> enrolledCourses;
  List<User> connections;
  double overallProgress;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.enrolledCourses = const [],
    this.connections = const [],
    this.overallProgress = 0.0,
  });

  get memberSince => null;
}
