import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Auth/login_screen.dart';
import '../task_screen.dart'; // Replace with your actual home screen

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = Supabase.instance.client.auth.currentSession;

        if (!snapshot.hasData) {
          // Still loading or no auth state yet
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // User is signed in
        if (session != null) {
          return const TaskScreen(); // Replace with your authenticated screen
        }

        // User is signed out
        return const LoginScreen();
      },
    );
  }
}
