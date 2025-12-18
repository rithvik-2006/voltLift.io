// import 'package:flutter/material.dart';

// class WorkoutLoggerScreen extends StatelessWidget {
//   const WorkoutLoggerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Log Workout')),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {},
//         label: const Text('Add Set'),
//         icon: const Icon(Icons.add),
//       ),
//       body: const Center(
//         child: Text(
//           'Workout Logger\n(weight × reps)',
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/workout_set.dart';
import '../services/workout_service.dart';

class WorkoutLoggerScreen extends StatefulWidget {
  const WorkoutLoggerScreen({super.key});

  @override
  State<WorkoutLoggerScreen> createState() => _WorkoutLoggerScreenState();
}

class _WorkoutLoggerScreenState extends State<WorkoutLoggerScreen> {
  final WorkoutService _service = WorkoutService();

  final TextEditingController _exerciseCtrl =
      TextEditingController(text: "Bench Press");

  final List<WorkoutSet> _sets = [];

  void _addSetDialog() {
    final weightCtrl = TextEditingController();
    final repsCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Set'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: weightCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
            ),
            TextField(
              controller: repsCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Reps'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _sets.add(
                  WorkoutSet(
                    weight: double.parse(weightCtrl.text),
                    reps: int.parse(repsCtrl.text),
                  ),
                );
              });
              Navigator.pop(context);
            },
            child: const Text('ADD'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveWorkout() async {
    if (_sets.isEmpty) return;

    await _service.saveWorkout(
      exercise: _exerciseCtrl.text,
      sets: _sets,
    );

    setState(() => _sets.clear());
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Workout Saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Workout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveWorkout,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addSetDialog,
        label: const Text('Add Set'),
        icon: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _exerciseCtrl,
              decoration: const InputDecoration(
                labelText: 'Exercise Name',
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _sets.length,
                itemBuilder: (_, i) {
                  final s = _sets[i];
                  return ListTile(
                    title: Text('${s.weight} kg × ${s.reps} reps'),
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
