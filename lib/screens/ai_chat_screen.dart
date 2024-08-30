// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillforge_ai/models/chat_message.dart';
import 'package:skillforge_ai/services/openai_service.dart';
import 'package:skillforge_ai/widgets/chat_bubble.dart';
import 'package:skillforge_ai/widgets/input_field.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  _AIChatScreenState createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ilara AI Chat'),
        backgroundColor: const Color(0xFF75B027),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ChatBubble(message: _messages[index]),
                  );
                },
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 6,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: InputField(
                controller: _textController,
                labelText: 'Type your message...',
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 12),
            _buildSendButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF75B027),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.send, color: Colors.white),
        onPressed: _sendMessage,
      ),
    );
  }

  void _sendMessage() async {
    if (_textController.text.isEmpty) return;

    final userMessage = ChatMessage(
      text: _textController.text,
      isUser: true,
    );

    setState(() {
      _messages.add(userMessage);
      _textController.clear();
    });

    _scrollToBottom();

    try {
      final response = await Provider.of<OpenAIService>(context, listen: false)
          .getChatResponse(userMessage.text);

      setState(() {
        _messages.add(ChatMessage(
          text: response,
          isUser: false,
        ));
      });

      _scrollToBottom();
    } catch (e) {
      _showErrorSnackBar(e.toString());
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _showErrorSnackBar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $errorMessage'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
