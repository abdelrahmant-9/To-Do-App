import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/providers/locale_provider.dart';
import 'package:todo_app/core/widgets/custom_button.dart';
import 'package:todo_app/core/widgets/custom_textfield.dart';
import 'package:todo_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:todo_app/features/auth/presentation/views/register_screen.dart';
import 'package:todo_app/injection_container.dart' as di;
import 'package:todo_app/l10n/app_localizations.dart';

void main() {
  Widget createRegisterScreen() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel(di.sl(), di.sl(), di.sl(), di.sl())),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: RegisterScreen(),
      ),
    );
  }

  setUpAll(() async {
    await di.init();
  });

  group('Register Screen Validation Tests', () {
    testWidgets('should show error message when name is empty', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createRegisterScreen());

      // Act
      final signUpButton = find.byType(CustomButton);
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Full name is required'), findsOneWidget);
    });

    testWidgets('should show error for short password', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createRegisterScreen());

      // Act
      final passwordField = find.widgetWithText(CustomTextField, 'Password');
      await tester.enterText(passwordField, '123');
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Password must be at least 8 characters'), findsOneWidget);
    });

    testWidgets('should show error when passwords do not match', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createRegisterScreen());

      // Act
      final passwordField = find.widgetWithText(CustomTextField, 'Password');
      await tester.enterText(passwordField, 'Password123!');

      final confirmPasswordField = find.widgetWithText(CustomTextField, 'Confirm Password');
      await tester.enterText(confirmPasswordField, 'Password123'); // Mismatch

      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Passwords do not match'), findsOneWidget);
    });
  });
}
