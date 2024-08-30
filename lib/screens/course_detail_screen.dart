import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillforge_ai/models/course.dart';
import 'package:skillforge_ai/services/openai_service.dart';
import 'package:skillforge_ai/services/enrollment_service.dart';
import 'package:skillforge_ai/services/auth_service.dart';
import 'package:skillforge_ai/widgets/button.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade50, Colors.white],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.teal.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Course Outline',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.teal.shade700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    FutureBuilder<String>(
                      future: Provider.of<OpenAIService>(context, listen: false)
                          .generateCourseContent(course.title),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(snapshot.data ?? 'No content available');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Button(
              onPressed: () async {
                final authService =
                    Provider.of<AuthService>(context, listen: false);
                final enrollmentService =
                    Provider.of<EnrollmentService>(context, listen: false);
                final user = authService.currentUser;

                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please log in to enroll in courses')),
                  );
                  return;
                }

                try {
                  await enrollmentService.enrollInCourse(user.id, course.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Successfully enrolled in ${course.title}')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Error enrolling in course: ${e.toString()}')),
                  );
                }
              },
              text: 'Enroll in Course',
            ),
          ],
        ),
      ),
    );
  }
}
