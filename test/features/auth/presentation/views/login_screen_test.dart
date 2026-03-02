import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/providers/locale_provider.dart';
import 'package:todo_app/core/widgets/custom_button.dart';
import 'package:todo_app/core/widgets/custom_textfield.dart';
import 'package:todo_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:todo_app/features/auth/presentation/views/login_screen.dart';
import 'package:todo_app/injection_container.dart' as di;
import 'package:todo_app/l10n/app_localizations.dart';

void main() {
  Widget createLoginScreen() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel(di.sl(), di.sl(), di.sl(), di.sl())),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LoginScreen(),
      ),
    );
  }

  setUpAll(() async {
    await di.init();
  });

  group('Login Screen Validation Tests', () {
    testWidgets('should show error message when email is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      final signInButton = find.byType(CustomButton);
      await tester.tap(signInButton);
      await tester.pumpAndSettle();
      expect(find.text('Email is required'), findsOneWidget);
    });

    testWidgets('should show error message for invalid email format', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      final emailField = find.byType(CustomTextField).first;
      await tester.enterText(emailField, 'invalid-email');
      await tester.pumpAndSettle();
      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('should show error message when password is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      final emailField = find.byType(CustomTextField).first;
      await tester.enterText(emailField, 'test@test.com');
      final signInButton = find.byType(CustomButton);
      await tester.tap(signInButton);
      await tester.pumpAndSettle();
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('should show error message for short password', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      final passwordField = find.widgetWithText(CustomTextField, 'Password');
      await tester.enterText(passwordField, '123');
      await tester.pumpAndSettle();
      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    });
  });
}
