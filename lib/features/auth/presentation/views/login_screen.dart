import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/providers/locale_provider.dart';
import 'package:todo_app/core/utils/validators.dart';
import 'package:todo_app/core/widgets/custom_button.dart';
import 'package:todo_app/core/widgets/custom_textfield.dart';
import 'package:todo_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:todo_app/features/auth/presentation/views/forgot_password_screen.dart';
import 'package:todo_app/features/auth/presentation/views/register_screen.dart';
import 'package:todo_app/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFFCF5F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              if (localeProvider.locale.languageCode == 'en') {
                localeProvider.setLocale(const Locale('ar'));
              } else {
                localeProvider.setLocale(const Locale('en'));
              }
            },
            child: Text(
              localeProvider.locale.languageCode == 'en' ? "عربي" : "Eng",
              style: const TextStyle(color: Color(0xFFFE466D)),
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFFFE466D)),
        ],
      ),
      body: SafeArea(
        child: Consumer<AuthViewModel>(
          builder: (context, viewModel, child) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 150,
                    ),
                    const SizedBox(height: 48),
                    CustomTextField(
                      controller: _emailController,
                      hintText: l10n.email,
                      validator: (value) => Validators.validateEmail(value, l10n),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      errorText: viewModel.emailError,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: l10n.password,
                      obscureText: !_isPasswordVisible,
                      suffixIcon: _isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      onSuffixIconPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      validator: (value) => Validators.validateSignInPassword(value, l10n),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      errorText: viewModel.passwordError,
                    ),
                     Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          l10n.forgotPassword,
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                     if (viewModel.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      CustomButton(
                        text: l10n.signIn,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            viewModel.signIn(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                      ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(l10n.dontHaveAnAccount, style: const TextStyle(color: Colors.grey)),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(l10n.signUp, style: const TextStyle(color: Color(0xFFFE466D))),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
