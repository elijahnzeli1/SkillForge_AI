import 'package:flutter/material.dart';
import 'package:skillforge_ai/widgets/button.dart';
import 'package:skillforge_ai/widgets/input_field.dart';

class SupportScreen extends StatelessWidget {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.cyan.shade50, Colors.white],
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
                      'Frequently Asked Questions',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.cyan.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    const ExpansionTile(
                      title: Text('How do I reset my password?'),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                              'To reset your password, go to the login screen and tap on "Forgot Password". Follow the instructions sent to your email.'),
                        ),
                      ],
                    ),
                    const ExpansionTile(
                      title: Text(
                          'How can I download course content for offline use?'),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                              'On the course detail screen, look for the "Download" button. This will save the course content for offline access.'),
                        ),
                      ],
                    ),
                    // Add more FAQs as needed
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
                      'Contact Support',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.cyan.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    InputField(
                      controller: _subjectController,
                      labelText: 'Subject',
                      onSubmitted: (_) {},
                    ),
                    const SizedBox(height: 16),
                    InputField(
                      controller: _messageController,
                      labelText: 'Message',
                      maxLines: 5,
                      onSubmitted: (_) {},
                    ),
                    const SizedBox(height: 16),
                    Button(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Support ticket submitted')),
                        );
                        _subjectController.clear();
                        _messageController.clear();
                      },
                      text: 'Submit Ticket',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
