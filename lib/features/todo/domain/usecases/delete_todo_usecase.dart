
import 'package:todo_app/features/todo/domain/repository/todo_repository.dart';

class DeleteTodoUseCase {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteTodo(id);
  }
}
