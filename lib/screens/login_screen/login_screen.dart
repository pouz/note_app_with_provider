import 'package:flutter/material.dart';
import 'package:note_app/features/login/firebase/firebase_login.dart';
import 'package:note_app/screens/home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () async {
              FirebaseLogin.signInWithGoogle().then(
                (value) {
                  return Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
              );
            },
            child: const Text('Google Sign in'),
          ),
        ],
      ),
    );
  }
}
