import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/controllers/auth_controller.dart';
import 'package:todo_flutter/pages/home_page.dart';
import 'package:todo_flutter/pages/sign_in_account_page.dart';

import 'controllers/task_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await TaskController().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.light(
              primary: Colors.indigoAccent
          )
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Colors.black54
        )
      ),
      themeMode: ThemeMode.system,
      home: StreamBuilder<bool>(
          stream: AuthController().loggedInStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return snapshot.data == true
              ? const HomePage()
              : const SignInAccountPage();
        },
      ),
    );
  }
}
