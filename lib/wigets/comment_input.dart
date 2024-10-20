import 'package:flutter/material.dart';

// Widget untuk input komentar
Widget commentInputField(
    TextEditingController commentController, Function(String) addComment) {
  return Row(
    children: [
      Expanded(
        child: TextField(
          controller: commentController,
          decoration: const InputDecoration(
            hintText: "Add a comment...",
          ),
        ),
      ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: () {
          String newComment = commentController.text;
          if (newComment.isNotEmpty) {
            addComment(newComment);
          }
        },
      ),
    ],
  );
}
