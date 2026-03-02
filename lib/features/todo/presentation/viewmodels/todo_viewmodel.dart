
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_app/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:todo_app/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:todo_app/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:todo_app/features/todo/domain/usecases/update_todo_usecase.dart';

class TodoViewModel extends ChangeNotifier {
  final GetTodosUseCase _getTodosUseCase;
  final AddTodoUseCase _addTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;

  TodoViewModel(
    this._getTodosUseCase,
    this._addTodoUseCase,
    this._updateTodoUseCase,
    this._deleteTodoUseCase,
  );

  List<TodoEntity> _todos = [];
  List<TodoEntity> get todos => _todos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  StreamSubscription? _todosSubscription;

  void getTodos(String userId) {
    _isLoading = true;
    _error = null;
    notifyListeners();

    _todosSubscription?.cancel();
    _todosSubscription = _getTodosUseCase(userId).listen((todos) {
      _todos = todos;
      _isLoading = false;
      notifyListeners();
    }, onError: (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addTodo(TodoEntity todo) async {
    try {
      await _addTodoUseCase(todo);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateTodo(TodoEntity todo) async {
    try {
      await _updateTodoUseCase(todo);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _deleteTodoUseCase(id);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _todosSubscription?.cancel();
    super.dispose();
  }
}
