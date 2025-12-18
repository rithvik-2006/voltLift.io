class WorkoutSet {
  final double weight;
  final int reps;

  WorkoutSet({required this.weight, required this.reps});

  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'reps': reps,
    };
  }

  factory WorkoutSet.fromMap(Map<String, dynamic> map) {
    return WorkoutSet(
      weight: (map['weight'] as num).toDouble(),
      reps: map['reps'],
    );
  }
}
