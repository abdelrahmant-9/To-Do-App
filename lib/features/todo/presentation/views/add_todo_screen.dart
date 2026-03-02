import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_app/features/todo/presentation/viewmodels/todo_viewmodel.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _deadline;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _deadline ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
       builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _deadline) {
      setState(() {
        _deadline = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0).copyWith(top: 16.0, bottom: 32.0),
      decoration: const BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 8,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      _deadline == null ? 'Deadline (Optional)' : DateFormat('dd MMMM yyyy').format(_deadline!),
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
                    ),
                    const Icon(Icons.calendar_today_outlined, color: Colors.white)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add Image (Optional)', style: TextStyle(color: Colors.white.withValues(alpha: 0.8))),
                  const Icon(Icons.image_outlined, color: Colors.white)
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
                    final todo = TodoEntity(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      deadline: _deadline,
                    );
                    Provider.of<TodoViewModel>(context, listen: false).addTodo(todo);
                    Navigator.of(context).pop();
                  } else {
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Title and description cannot be empty")),
                    );
                  }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'ADD TODO',
                style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
