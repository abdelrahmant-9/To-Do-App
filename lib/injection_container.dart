import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:todo_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:todo_app/features/auth/domain/repository/auth_repository.dart';
import 'package:todo_app/features/auth/domain/usecases/get_user_profile_usecase.dart';
import 'package:todo_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:todo_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:todo_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:todo_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:todo_app/features/todo/data/datasource/todo_remote_datasource.dart';
import 'package:todo_app/features/todo/data/repository/todo_repository_impl.dart';
import 'package:todo_app/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_app/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:todo_app/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:todo_app/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:todo_app/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:todo_app/features/todo/presentation/viewmodels/todo_viewmodel.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ViewModels
  sl.registerFactory(() => AuthViewModel(
        sl(),
        sl(),
        sl(),
        sl(), // Added GetUserProfileUseCase
      ));

  sl.registerFactory(() => TodoViewModel(
        sl(),
        sl(),
        sl(),
        sl(),
      ));

  // UseCases
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => AddTodoUseCase(sl()));
  sl.registerLazySingleton(() => GetTodosUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTodoUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTodoUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(sl()),
  );

  // DataSource
  sl.registerLazySingleton(
    () => AuthRemoteDataSource(FirebaseFirestore.instance),
  );
  sl.registerLazySingleton(
    () => TodoRemoteDataSource(FirebaseFirestore.instance),
  );
}
