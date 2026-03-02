import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/providers/locale_provider.dart';
import 'package:todo_app/core/utils/validators.dart';
import 'package:todo_app/core/widgets/custom_button.dart';
import 'package:todo_app/core/widgets/custom_textfield.dart';
import 'package:todo_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:todo_app/features/todo/presentation/views/home_screen.dart';
import 'package:todo_app/l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFFCF5F6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            if (viewModel.user != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              });
            }

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
                      controller: _nameController,
                      hintText: l10n.fullName,
                      validator: (value) => Validators.validateName(value, l10n),
                       autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      validator: (value) => Validators.validateSignUpPassword(value, l10n),
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      errorText: viewModel.passwordError,
                    ),
                    const SizedBox(height: 16),
                     CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: l10n.confirmPassword,
                      obscureText: !_isConfirmPasswordVisible,
                      suffixIcon: _isConfirmPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                       onSuffixIconPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.confirmPasswordIsRequired;
                        }
                        if (value != _passwordController.text) {
                          return l10n.passwordsDoNotMatch;
                        }
                        return null;
                      },
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 32),
                    if (viewModel.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      CustomButton(
                        text: l10n.signUp,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            viewModel.signUp(
                              _emailController.text,
                              _passwordController.text,
                              _nameController.text,
                            );
                          }
                        },
                      ),
                     const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(l10n.haveAnAccount, style: const TextStyle(color: Colors.grey)),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(l10n.signIn, style: const TextStyle(color: Color(0xFFFE466D))),
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
