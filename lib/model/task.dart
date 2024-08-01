import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String details;
  final DateTime? dueDate;
  final bool isDone;
  final bool isDeleted;
  final bool isPinned;

  Task({
    required this.id,
    required this.title,
    required this.details,
    this.dueDate,
    this.isDone = false,
    this.isDeleted = false,
    this.isPinned = false,
  });

  Task copyWith({
    String? id,
    String? title,
    String? details,
    DateTime? dueDate,
    bool? isDone,
    bool? isDeleted,
    bool? isPinned,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      dueDate: dueDate ?? this.dueDate,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, details, dueDate, isDone, isDeleted, isPinned];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'dueDate': dueDate?.toIso8601String(),
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isPinned': isPinned,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      details: map['details'],
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
      isPinned: map['isPinned'],
    );
  }
}
