class Course {
  final String id;
  final String title;
  final String description;
  double progress;

  Course({
    required this.id,
    required this.title,
    required this.description,
    this.progress = 0.0,
  });

  static Course fromJson(String courseJson) {
    throw UnimplementedError('fromJson method is not implemented yet.');
  }

  String toJson() {
    // Add your implementation here
    return '';
  }
}
