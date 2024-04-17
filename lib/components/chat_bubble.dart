import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool iscurrentUser;
  const ChatBubble(
      {super.key, required this.message, required this.iscurrentUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: iscurrentUser ? const Color.fromARGB(255, 113, 226, 116) :  Colors.grey,
        ),
        padding: EdgeInsets.all(15.0),
        child: Text(message,
               style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
