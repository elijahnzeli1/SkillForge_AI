// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:skillforge_ai/utils/constants.dart'; // Replace with your actual API key
import 'dart:async';

class OpenAIService extends ChangeNotifier {
  final String _baseUrl = 'https://api.openai.com/v1/chat/completions';
  final String _apiKey = 'openaiApiKey'; // Replace with your actual API key

  Future<String> generateCourseContent(String courseName) async {
    int retryCount = 0;
    const int maxRetries = 5;
    const Duration initialDelay = Duration(seconds: 1);

    while (retryCount < maxRetries) {
      try {
        final response = await http.post(
          Uri.parse(_baseUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_apiKey',
          },
          body: jsonEncode({
            'model': 'gpt-3.5-turbo',
            'messages': [
              {'role': 'system', 'content': 'You are a helpful AI assistant.'},
              {
                'role': 'user',
                'content': 'Generate content for the course: $courseName'
              },
            ],
            'max_tokens': 150,
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return data['choices'][0]['message']['content'];
        } else if (response.statusCode == 429) {
          retryCount++;
          final delay = initialDelay * retryCount;
          await Future.delayed(delay);
        } else {
          throw Exception(
              'Failed to get chat response: ${response.statusCode}');
        }
      } catch (e) {
        if (retryCount >= maxRetries - 1) {
          throw Exception(
              'Failed to generate course content after $maxRetries attempts: $e');
        }
        retryCount++;
        final delay = initialDelay * retryCount;
        await Future.delayed(delay);
      }
    }
    throw Exception(
        'Failed to generate course content after $maxRetries attempts');
  }

  void showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  getChatResponse(String text) {}
}
