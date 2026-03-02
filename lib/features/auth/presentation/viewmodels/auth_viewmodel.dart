import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/auth/domain/entities/user_entity.dart';
import 'package:todo_app/features/auth/domain/usecases/get_user_profile_usecase.dart';
import 'package:todo_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:todo_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:todo_app/features/auth/domain/usecases/register_usecase.dart';

class AuthViewModel extends ChangeNotifier {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthViewModel(this._getUserProfileUseCase, this._loginUseCase, this._registerUseCase, this._logoutUseCase);

  UserEntity? _user;
  UserEntity? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _emailError;
  String? get emailError => _emailError;

  String? _passwordError;
  String? get passwordError => _passwordError;

  void setUser(UserEntity user) {
    _user = user;
    notifyListeners();
  }

  Future<void> loadUserProfile(String uid) async {
    _isLoading = true;
    notifyListeners();
    final user = await _getUserProfileUseCase(uid);
    if (user != null) {
      _user = user;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _emailError = null;
    _passwordError = null;
    notifyListeners();

    try {
      final user = await _loginUseCase(email, password);
      if (user != null) {
        _user = user; 
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-email' || e.code == 'invalid-credential') {
        _emailError = e.message;
      } else if (e.code == 'wrong-password') {
        _passwordError = e.message;
      } else {
        _emailError = 'An unexpected error occurred.';
      }
       return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    _isLoading = true;
    _emailError = null;
    _passwordError = null;
    notifyListeners();

    try {
       final user = await _registerUseCase(email, password, name);
       if (user != null) {
        _user = user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use' || e.code == 'invalid-email') {
        _emailError = e.message;
      } else if (e.code == 'weak-password') {
        _passwordError = e.message;
      } else {
        _emailError = 'An unexpected error occurred.';
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _logoutUseCase();
    _user = null;
    notifyListeners();
  }
}
