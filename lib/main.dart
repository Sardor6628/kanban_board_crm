import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/blocks/authentication/auth_bloc.dart';
import 'package:kanban_board/blocks/task_block/task_bloc.dart';
import 'package:kanban_board/constants/routes.dart';
import 'package:kanban_board/presentation/authentication/sign_in.dart';
import 'package:kanban_board/presentation/dashboard/dashoboard.dart';
import 'package:kanban_board/repositories/auth_repository.dart';
import 'package:kanban_board/repositories/task_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => TaskRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider(
              create: (context) => TaskBloc(
                    RepositoryProvider.of<TaskRepository>(context),
                  )..add(TasksLoad())),
        ],
        child: MaterialApp(
          title: 'Kanban Board',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                background: const Color(0xffF5F5F5),
                  primary: const Color(0xff0059B4),
                  secondary: const Color(0xff2789FD))),
          darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: const Color(0xff0059B4),
                  secondary: const Color(0xff2789FD))),
          themeMode: ThemeMode.system,

          routes: navRoutes,
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                if (snapshot.hasData) {
                  return Dashboard(
                    user: snapshot.data!,
                  );
                }
                // Otherwise, they're not signed in. Show the sign in page.
                return SignIn();
              }),
          // home: const DashboardPage()
          // home: const SplashScreen()
        ),
      ),
    );
  }
}
