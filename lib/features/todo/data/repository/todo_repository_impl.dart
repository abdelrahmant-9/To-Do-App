
import 'package:todo_app/features/todo/data/datasource/todo_remote_datasource.dart';
import 'package:todo_app/features/todo/data/models/todo_model.dart';
import 'package:todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_app/features/todo/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<TodoEntity>> getTodos(String userId) {
    return remoteDataSource.getTodos(userId).map((models) {
      return models.map((model) => model as TodoEntity).toList();
    });
  }

  @override
  Future<void> addTodo(TodoEntity todo) async {
    final todoModel = TodoModel.fromEntity(todo);
    await remoteDataSource.addTodo(todoModel);
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    final todoModel = TodoModel.fromEntity(todo);
    await remoteDataSource.updateTodo(todoModel);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await remoteDataSource.deleteTodo(id);
  }
}
