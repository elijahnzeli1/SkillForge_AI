// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillforge_ai/services/auth_service.dart';
import 'package:skillforge_ai/services/openai_service.dart';
import 'package:skillforge_ai/screens/home_screen.dart';
import 'dart:math' show pi, cos, sin;

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService(context)),
        ChangeNotifierProvider(create: (context) => OpenAIService()),
        // Add other providers here if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillForge AI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Simulate app initialization
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SkillForge AI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            FourRotatingDots(controller: _controller),
          ],
        ),
      ),
    );
  }
}

class FourRotatingDots extends StatelessWidget {
  final AnimationController controller;

  const FourRotatingDots({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: List.generate(4, (index) {
          final position = index * 0.25;
          return Positioned.fill(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: (controller.value + position) * 2 * pi,
                  child: Align(
                    alignment: Alignment(
                      cos((controller.value + position) * 2 * pi) * 0.5,
                      sin((controller.value + position) * 2 * pi) * 0.5,
                    ),
                    child: const Dot(),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
    );
  }
}
