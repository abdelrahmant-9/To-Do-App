
import 'package:todo_app/features/auth/domain/entities/user_entity.dart';
import 'package:todo_app/features/auth/domain/repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserEntity?> call(String email, String password, String name) {
    return repository.signUp(email, password, name);
  }
}
