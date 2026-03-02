
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/features/todo/domain/entities/todo_entity.dart';

class TodoItemCard extends StatelessWidget {
  final TodoEntity todo;
  final VoidCallback onTap;

  const TodoItemCard({super.key, required this.todo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = todo.isCompleted ? AppColors.secondary : AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  todo.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.watch_later_outlined, color: Colors.white, size: 20),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              todo.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              'Created at ${DateFormat('d MMM yyyy').format(todo.createdAt ?? DateTime.now())}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
