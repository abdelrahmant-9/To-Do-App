import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/core/app_colors.dart';
import 'package:todo_app/features/auth/presentation/components/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              if (context.locale == Locale('ar')) {
                context.setLocale(Locale('en'));
              } else {
                context.setLocale(Locale('ar'));
              }
            },
            child: Row(
              children: [
                Text(
                  "locale".tr(),
                  style: TextStyle(
                    color: AppColors.pinkRed,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: AppColors.pinkRed,
                  size: 27,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            SizedBox(height: 90),
            SvgPicture.asset('assets/images/Logo.svg'),
            SizedBox(height: 12),

            CustomTextFormField(
              hint: "email".tr(),
              controller: _emailController,
            ),
            SizedBox(height: 12),

            CustomTextFormField(
              hint: "full_name".tr(),
              controller: _fullNameController,
            ),
            SizedBox(height: 12),

            CustomTextFormField(
              hint: "password".tr(),
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: 12),

            CustomTextFormField(
              hint: "confirm_password".tr(),
              controller: _confirmPasswordController,
              obscureText: true,

            ),
          ],
        ),
      ),
    );
  }
}

