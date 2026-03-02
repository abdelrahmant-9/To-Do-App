import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_app/features/todo/presentation/viewmodels/todo_viewmodel.dart';
import 'package:todo_app/features/todo/presentation/views/delete_dialog.dart';
import 'package:todo_app/features/todo/presentation/views/edit_todo_screen.dart';

class DetailTodoScreen extends StatelessWidget {
  final TodoEntity todo;

  const DetailTodoScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.watch_later_outlined, color: AppColors.text),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.text),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => EditTodoScreen(todo: todo),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.text),
            onPressed: () {
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: '',
                barrierColor: AppColors.text.withOpacity(0.5),
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (context, animation1, animation2) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: DeleteTodoSheet(
                      onDelete: () async { 
                        await Provider.of<TodoViewModel>(context, listen: false).deleteTodo(todo.id!);
                        if (context.mounted) {
                          Navigator.of(context).pop(); // Close dialog
                          Navigator.of(context).pop(); // Go back to home screen
                        }
                      },
                    ),
                  );
                },
                transitionBuilder: (context, animation1, animation2, child) {
                  return SlideTransition(
                    position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(animation1),
                    child: child,
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.text),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  todo.description,
                  style: const TextStyle(fontSize: 16, height: 1.7, color: AppColors.text),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
                child: Text(
                  'Created at ${DateFormat('d MMM yyyy').format(todo.createdAt ?? DateTime.now())}',
                  style: const TextStyle(color: AppColors.textLight, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
