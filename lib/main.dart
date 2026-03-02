import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/providers/locale_provider.dart';
import 'package:todo_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:todo_app/features/auth/presentation/views/auth_wrapper.dart';
import 'package:todo_app/features/todo/presentation/viewmodels/todo_viewmodel.dart';
import 'package:todo_app/injection_container.dart' as di;
import 'firebase_options.dart';
import 'package:todo_app/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set status bar style to make icons visible on light background
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<AuthViewModel>()),
        ChangeNotifierProvider(create: (_) => di.sl<TodoViewModel>()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Poppins',
            ),
            locale: provider.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const AuthWrapper(),
          );
        },
      ),
    );
  }
}
