import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uws/Screens/LoginPage.dart';
import 'package:uws/Screens/OtherScreen.dart';
import 'package:uws/Screens/SchoolScreen.dart';

class MyAppRouter {
  GoRouter myRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: LandingPageScreen());
        },
      ),
      GoRoute(
        path: '/schools', //username as a parameter
        pageBuilder: (context, state) {
          return const MaterialPage(child: SchoolSelectionScreen());
        },
      ),
      GoRoute(
        path: '/programs',
        pageBuilder: (context, state) {
          return const MaterialPage(child: Otherscreen());
        },
      ),
    ],
  );
}
