
import 'package:todo_app/features/auth/domain/repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}
