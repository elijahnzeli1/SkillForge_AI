import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillforge_ai/models/course.dart' as model;
import 'package:skillforge_ai/services/offline_service.dart';
import 'package:skillforge_ai/screens/offline_course_content_screen.dart';

class OfflineCourseScreen extends StatelessWidget {
  const OfflineCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Courses'),
        backgroundColor: const Color.fromARGB(255, 63, 134, 181),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade50, Colors.white],
          ),
        ),
        child: FutureBuilder<List<model.Course>>(
          future: Provider.of<OfflineService>(context, listen: false)
              .getOfflineCourses() as Future<List<model.Course>>?,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No offline courses available'));
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final course = snapshot.data![index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        course.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.indigo.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        course.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing:
                          const Icon(Icons.offline_pin, color: Colors.green),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OfflineCourseContentScreen(course: course),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
