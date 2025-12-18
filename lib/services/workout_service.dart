import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/workout_set.dart';

class WorkoutService {
  final _db = FirebaseFirestore.instance;

  final String userId = "demo-user"; // replace with auth later

  Future<void> saveWorkout({
    required String exercise,
    required List<WorkoutSet> sets,
  }) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('workouts')
        .add({
      'exerciseName': exercise,
      'createdAt': FieldValue.serverTimestamp(),
      'sets': sets.map((s) => s.toMap()).toList(),
    });
  }

  Stream<QuerySnapshot> getWorkouts() {
    return _db
        .collection('users')
        .doc(userId)
        .collection('workouts')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
