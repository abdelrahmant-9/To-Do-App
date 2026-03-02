import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:todo_app/features/auth/presentation/views/forgot_password_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // Illustration
            Image.asset('assets/images/rafiki.png', height: 300),
            const SizedBox(height: 48),

            // Profile Options
            _buildProfileOption(context, 'Name', authViewModel.user?.name ?? 'No Name'),
            _buildProfileOption(context, 'Email', authViewModel.user?.email ?? 'No Email'),
            _buildProfileOption(
              context,
              'Change Password',
              '＞',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                );
              },
            ),
            _buildProfileOption(context, 'Change Language', '＞'),

            const Spacer(),

            // Log Out Button
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextButton(
                onPressed: () async { // Make the function async
                  // First, sign out from the view model
                  await authViewModel.signOut();
                  // Then, pop all screens until we are back at the root (AuthWrapper)
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, String title, String value, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
