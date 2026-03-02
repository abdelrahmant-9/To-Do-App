
import 'package:todo_app/features/todo/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Stream<List<TodoEntity>> getTodos(String userId);
  Future<void> addTodo(TodoEntity todo);
  Future<void> updateTodo(TodoEntity todo);
  Future<void> deleteTodo(String id);
}
