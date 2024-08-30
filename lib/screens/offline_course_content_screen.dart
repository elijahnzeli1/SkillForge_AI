import 'package:flutter/material.dart';

import 'package:skillforge_ai/models/course.dart';

class OfflineCourseContentScreen extends StatelessWidget {
  final Course course;

  const OfflineCourseContentScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.indigo.shade700,
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 16),

            Text(
              course.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(

                  // Add your desired style here

                  ),
            ),

            // Add more content here as needed
          ],
        ),
      ),
    );
  }
}
