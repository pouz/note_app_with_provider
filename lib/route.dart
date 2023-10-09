import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/screens/home_screen/home_screen.dart';
import 'package:note_app/screens/login_screen/login_screen.dart';
import 'package:note_app/screens/not_found_screen/not_found_screen.dart';
import 'package:note_app/screens/note_editor_screen/note_editor_screen.dart';
import 'package:note_app/screens/note_reader_screen/note_reader_screen.dart';

class AppRoute {
  // TODO : change names to enum things.
  static const String root = '/';
  static const String login = '/login';
  static const String editor = '/editor';
  static const String reader = '/reader';
  static const String notFound = '/not_found';

  static final _rootNavigationKey = GlobalKey<NavigatorState>();
  static final _shellNavigationKey = GlobalKey<NavigatorState>();

  static final _router = GoRouter(
    initialLocation: root,
    navigatorKey: _rootNavigationKey,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigationKey,
        pageBuilder: (context, state, child) => NoTransitionPage(
          child: Container(
            child: child,
          ),
        ),
        routes: [
          GoRoute(
            path: root,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: _gotoWithLogin(const HomeScreen()),
            ),
          ),
          GoRoute(
            path: login,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const LoginScreen(),
            ),
          ),
          GoRoute(
            path: editor,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                  child: _gotoWithLogin(state.extra == null
                      ? const NoteEditorScreen()
                      : NoteEditorScreen(note: state.extra as Note)));
            },
          ),
          GoRoute(
            path: reader,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                  child: _gotoWithLogin(
                      NoteReaderScreen(note: state.extra as Note)));
            },
          ),
          GoRoute(
            path: notFound,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: _gotoWithLogin(const NotFoundScreen()),
            ),
          ),
        ],
      ),
    ],
  );

  static StreamBuilder<User?> _gotoWithLogin(Widget child) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> user) {
        if (user.hasData) {
          return child;
        } else {
          return const LoginScreen();
        }
      },
    );
  }

  static GoRouter get router => _router;
}
