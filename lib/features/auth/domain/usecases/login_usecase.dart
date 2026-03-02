
import 'package:todo_app/features/auth/domain/entities/user_entity.dart';
import 'package:todo_app/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity?> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
