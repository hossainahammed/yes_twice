import 'dart:convert';

class WorkoutModel {
  final String id;
  final String type; // e.g. Swimming, Running, Gym
  final int duration; // in minutes
  final int rpe; // 1-10
  final DateTime date;

  WorkoutModel({
    required this.id,
    required this.type,
    required this.duration,
    required this.rpe,
    required this.date,
  });

  // Workload is duration * RPE
  int get workload => duration * rpe;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'duration': duration,
      'rpe': rpe,
      'date': date.toIso8601String(),
    };
  }

  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
    return WorkoutModel(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      duration: map['duration'] ?? 0,
      rpe: map['rpe'] ?? 0,
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkoutModel.fromJson(String source) => WorkoutModel.fromMap(json.decode(source));
}
