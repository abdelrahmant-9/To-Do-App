
import 'package:todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_app/features/todo/domain/repository/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase(this.repository);

  Future<void> call(TodoEntity todo) {
    return repository.updateTodo(todo);
  }
}
