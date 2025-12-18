import 'package:flutter/material.dart';
import '../services/workout_service.dart';

class WorkoutHistoryScreen extends StatelessWidget {
  final WorkoutService _service = WorkoutService();

  WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout History')),
      body: StreamBuilder(
        stream: _service.getWorkouts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final data = docs[i];
              final sets = data['sets'] as List;

              return Card(
                child: ListTile(
                  title: Text(data['exerciseName']),
                  subtitle: Text('${sets.length} sets'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
