// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class CourseSelectionScreen extends StatefulWidget {
  const CourseSelectionScreen({super.key});

  @override
  _CourseSelectionScreenState createState() => _CourseSelectionScreenState();
}

class _CourseSelectionScreenState extends State<CourseSelectionScreen> {
  final List<String> _topics = [
    'Machine Learning',
    'Web Development',
    'Mobile App Development',
    'Data Science',
    'Artificial Intelligence',
    'Cybersecurity',
    'Cloud Computing',
    'Blockchain',
    'Internet of Things',
    'Augmented Reality',
    'Virtual Reality',
    'Quantum Computing',
  ];

  List<Course> _courses = [];
  bool _isLoading = false;
  String _selectedTopic = '';

  @override
  void initState() {
    super.initState();
    _selectedTopic = _topics[0];
    _fetchCourses(_selectedTopic);
  }

  Future<void> _fetchCourses(String topic) async {
    setState(() {
      _isLoading = true;
    });

    const apiUrl = 'https://api.openai.com/v1/chat/completions';
    const apiKey =
        'sk-svcacct-Aupw0EOYy7QoWnJyOuBRqQxxfR0Q1teU-q--yHy5kCzQkYAfMT3BlbkFJ611EuLNaqTxZ6ARsAdbSKmA3gbskBkVIrJSdx-DWFAX7K1tAA'; // Replace with your actual API key

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content":
                  "You are a course creator assistant. Generate 5 courses for the given topic. Each course should have a unique ID, title, description, image URL, topic, and duration in weeks."
            },
            {"role": "user", "content": "Generate courses for: $topic"}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String coursesJson =
            responseData['choices'][0]['message']['content'];
        final List<dynamic> parsedCourses = jsonDecode(coursesJson);

        setState(() {
          _courses =
              parsedCourses.map((json) => Course.fromJson(json)).toList();
          _isLoading = false;
          _selectedTopic = topic;
        });
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI-Powered Course Selection'),
        backgroundColor: const Color.fromARGB(255, 58, 183, 156),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Explore AI-Generated Courses',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _topics.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(_topics[index]),
                    selected: _selectedTopic == _topics[index],
                    onSelected: (selected) {
                      if (selected) {
                        _fetchCourses(_topics[index]);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _courses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(course: _courses[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class Course {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String topic;
  final int durationInWeeks;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.topic,
    required this.durationInWeeks,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      topic: json['topic'],
      durationInWeeks: json['durationInWeeks'],
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(4.0)),
            child: CachedNetworkImage(
              imageUrl: course.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8.0),
                Text(
                  course.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16.0),
                    const SizedBox(width: 4.0),
                    Text('${course.durationInWeeks} weeks'),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement course enrollment logic
                        // You can add your code here to handle the course enrollment logic, such as making an API call to enroll the user in the selected course, updating the UI, etc.
                        // For example, you can show a dialog or navigate to a new screen to confirm the enrollment and provide additional details.
                        // Here's a basic example of how you can handle the enrollment logic:

                        // Assuming you have a method to enroll the user in a course
                        void enrollUserInCourse(Course course) {
                          // Implement your enrollment logic here
                          // For example, you can make an API call to enroll the user in the course
                          // or update the user's enrollment status in your database
                          // You can also show a success message or navigate to a new screen to confirm the enrollment
                        }

                        // Inside the onPressed callback of the ElevatedButton
                        // ignore: unused_label
                        onPressed:
                        () {
                          enrollUserInCourse(course);
                        };

                        // Add your code here
                      },
                      child: const Text('Enroll Now'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
