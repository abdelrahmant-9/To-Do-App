class TodoEntity {
  final String? id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime? createdAt;
  final DateTime? deadline; // Added deadline
  final String? imageUrl;   // Added image URL

  TodoEntity({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.createdAt,
    this.deadline,
    this.imageUrl,
  });
}
