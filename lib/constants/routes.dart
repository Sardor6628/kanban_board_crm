
import 'package:flutter/material.dart';
import 'package:kanban_board/presentation/authentication/sign_in.dart';
import 'package:kanban_board/presentation/authentication/sign_up.dart';
import 'package:kanban_board/presentation/dashboard/dashoboard.dart';

import '../presentation/history/history_page.dart';

Map<String, WidgetBuilder> navRoutes = {
  Routes.dashboardRoute: (context) => Dashboard(),
  Routes.loginRoute: (context) => const SignIn(),
  Routes.signUpRoute: (context) => const SignUp(),
  Routes.historyRoute: (context) => HistoryPage(),
};

class Routes {
  static String initialRoute = '/';
  static String loginRoute = '/login';
  static String signUpRoute = '/sign_up';
  static String dashboardRoute = '/dashboard';
  static String historyRoute = '/history';
}
