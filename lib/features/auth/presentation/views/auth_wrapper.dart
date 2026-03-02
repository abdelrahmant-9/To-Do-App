import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:todo_app/features/auth/presentation/views/login_screen.dart';
import 'package:todo_app/features/todo/presentation/views/home_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late final StreamSubscription<User?> _authSubscription;
  bool _isProfileLoaded = false;

  @override
  void initState() {
    super.initState();
    // Listen to authentication state changes
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      if (firebaseUser != null) {
        // If user is logged in, load their profile from Firestore
        Provider.of<AuthViewModel>(context, listen: false)
            .loadUserProfile(firebaseUser.uid)
            .then((_) {
          if (mounted) {
            setState(() {
              _isProfileLoaded = true; // Mark profile as loaded
            });
          }
        });
      } else {
        // If user is logged out, reset the state
        if (mounted) {
          setState(() {
            _isProfileLoaded = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel(); // Cancel the stream subscription
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use a consumer to react to user changes from login/logout
    return Consumer<AuthViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.user != null) {
          // If the user object exists in the viewmodel
          if (_isProfileLoaded) {
            // and the profile has been loaded, show the home screen
            return const HomeScreen();
          } else {
            // Otherwise, show a loading screen while the profile loads
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        } else {
          // If there is no user, show the login screen
          return const LoginScreen();
        }
      },
    );
  }
}
