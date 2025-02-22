import 'package:flutter/material.dart';
import 'post_sale_chat_support_page.dart';

class ProductCartPage extends StatelessWidget {
  final String guideId;

  const ProductCartPage({Key? key, required this.guideId}) : super(key: key); // Added const and key parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Cart and Payment'), // Added const
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Add payment integration here
            // For simplicity, we'll assume payment is successful
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostSaleChatSupportPage(guideId: guideId)),
            );
          },
          child: const Text('Proceed to Payment'), // Added const
        ),
      ),
    );
  }
}
