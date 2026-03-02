
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:todo_app/features/auth/domain/entities/user_entity.dart';
import 'package:todo_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity?> getUserProfile(String uid) async {
     return await remoteDataSource.getUserProfile(uid);
  }

  @override
  Future<UserEntity?> signIn(String email, String password) async {
    try {
      return await remoteDataSource.signIn(email, password);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<UserEntity?> signUp(String email, String password, String name) async {
    try {
      return await remoteDataSource.signUp(email, password, name);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}
