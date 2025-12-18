import 'package:flutter/material.dart';

class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout Templates')),
      body: const Center(
        child: Text('Create & edit workout routines'),
      ),
    );
  }
}
