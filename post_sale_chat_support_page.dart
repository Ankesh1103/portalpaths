import 'package:flutter/material.dart';

class PostSaleChatSupportPage extends StatelessWidget {
  final String guideId;

  const PostSaleChatSupportPage({Key? key, required this.guideId}) : super(key: key); // Added const and key parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Sale Chat Support'), // Added const
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add chat support integration here
            // For simplicity, we'll assume the chat support is initiated
          },
          child: const Text('Start Chat Support'), // Added const
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;

  const ChatMessage({Key? key, required this.message}) : super(key: key); // Added const and key parameter

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Added const
      child: Text(message),
    );
  }
}
