import 'package:todo_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> getUserProfile(String uid);
  Future<UserEntity?> signIn(String email, String password);
  Future<UserEntity?> signUp(String email, String password, String name);
  Future<void> signOut();
}
