import 'package:flutter/material.dart';

class CreatePostFab extends StatelessWidget {
  const CreatePostFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: const Color(0xFF179166),
      elevation: 4,
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 32,
      ),
    );
  }
}
