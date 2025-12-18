import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../routes.dart';
import '../services/workout_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WorkoutService service = WorkoutService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Neon Strength'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // START WORKOUT CTA
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.workout),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 28),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4D9CFF),
                      Color(0xFF9D6BFF),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.4),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'START WORKOUT',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Workouts',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            const SizedBox(height: 12),

            // 🔥 REAL FIRESTORE DATA
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: service.getWorkouts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No workouts yet'),
                    );
                  }

                  final workouts = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                      final data =
                          workouts[index].data() as Map<String, dynamic>;

                      final exercise = data['exerciseName'];
                      final sets = data['sets'] as List;

                      return _WorkoutCard(
                        title: exercise,
                        subtitle: '${sets.length} sets',
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _WorkoutCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _WorkoutCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
