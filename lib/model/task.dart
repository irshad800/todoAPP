import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String details;
  final DateTime? dueDate;
  bool? isDone;
  bool? isDeleted;

  Task({
    required this.id,
    required this.title,
    this.details = "",
    this.dueDate,
    this.isDone,
    this.isDeleted,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  Task copyWith({
    String? id,
    String? title,
    String? details,
    DateTime? dueDate,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      dueDate: dueDate ?? this.dueDate,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'dueDate': dueDate?.toIso8601String(),
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? "",
      title: map['title'] ?? "",
      details: map['details'] ?? "",
      dueDate: map['dueDate'] != null
          ? DateTime.parse(map['dueDate'])
          : null, // Parse DateTime
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
    );
  }

  @override
  List<Object?> get props => [id, title, details, dueDate, isDone, isDeleted];
}
