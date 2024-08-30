import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillforge_ai/models/course.dart';
import 'package:skillforge_ai/services/auth_service.dart';
import 'package:skillforge_ai/widgets/progress_bar.dart';

class UserProgressScreen extends StatelessWidget {
  const UserProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Progress'),
        backgroundColor: const Color.fromARGB(255, 0, 255, 191),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.white],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildUserProfile(context, user),
            const SizedBox(height: 16),
            _buildOverallProgressCard(context, user),
            const SizedBox(height: 16),
            Text(
              'Course Progress',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color.fromARGB(255, 78, 255, 172),
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ...(user?.enrolledCourses ?? [])
                .map((course) => _buildCourseProgressCard(context, course)),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(user?.profilePictureUrl ?? ''),
        ),
        const SizedBox(width: 16),
        Text(
          user?.name ?? 'User',
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Colors.orange.shade700,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildOverallProgressCard(BuildContext context, user) {
    return Card(
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
              'Overall Progress',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.orange.shade700,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ProgressBar(
              progress: user?.overallProgress ?? 0.0,
              color: Colors.orange,
            ),
            const SizedBox(height: 8),
            Text(
              '${((user?.overallProgress ?? 0.0) * 100).toStringAsFixed(1)}% Complete',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseProgressCard(BuildContext context, Course course) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.orange.shade700,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ProgressBar(
              progress: course.progress,
              color: Colors.orange,
            ),
            const SizedBox(height: 8),
            Text(
              '${(course.progress * 100).toStringAsFixed(1)}% Complete',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

extension on TextTheme {
  get headline6 => null;
}
