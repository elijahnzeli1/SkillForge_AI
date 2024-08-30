import 'package:flutter/material.dart';
import 'package:skillforge_ai/screens/ai_chat_screen.dart';
import 'package:skillforge_ai/screens/user_progress_screen.dart';
import 'package:skillforge_ai/screens/settings_screen.dart';
import 'package:skillforge_ai/screens/course_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const CourseSelectionScreen(),
    const AIChatScreen(),
    const UserProgressScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SkillForge AI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'AI Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: 'Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
