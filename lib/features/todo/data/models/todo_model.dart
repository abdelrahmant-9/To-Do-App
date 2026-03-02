
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/features/todo/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    String? id,
    required String title,
    required String description,
    bool isCompleted = false,
    DateTime? createdAt,
    DateTime? deadline,
    String? imageUrl,
  }) : super(
          id: id,
          title: title,
          description: description,
          isCompleted: isCompleted,
          createdAt: createdAt,
          deadline: deadline,
          imageUrl: imageUrl,
        );

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'] ?? false,
      createdAt: json['createdAt'] != null ? (json['createdAt'] as Timestamp).toDate() : null,
      deadline: json['deadline'] != null ? (json['deadline'] as Timestamp).toDate() : null,
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'deadline': deadline != null ? Timestamp.fromDate(deadline!) : null,
      'imageUrl': imageUrl,
    };
  }

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
      createdAt: entity.createdAt,
      deadline: entity.deadline,
      imageUrl: entity.imageUrl,
    );
  }
}
