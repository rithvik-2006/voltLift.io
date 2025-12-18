import 'package:flutter/material.dart';

class ExerciseHistoryScreen extends StatelessWidget {
  const ExerciseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise History')),
      body: const Center(
        child: Text('PRs & past workouts per exercise'),
      ),
    );
  }
}
