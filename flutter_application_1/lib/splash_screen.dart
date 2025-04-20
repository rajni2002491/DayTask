import 'package:flutter/material.dart';
import 'package:flutter_application_1/task_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2)); // Just for splash effect
    final session = Supabase.instance.client.auth.currentSession;

    if (mounted) {
      if (session != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TaskScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.01,
                left: screenWidth * 0.08,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/splash_top.png',
                  width: screenWidth * 0.22,
                  height: screenWidth * 0.14,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.3,
                    color: Colors.white,
                    child: Center(
                      child: Image.asset(
                        'assets/images/pana.png',
                        width: screenWidth * 0.6,
                        height: screenWidth * 0.6,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Image.asset(
                    'assets/images/splash_word.png',
                    width: screenWidth * 0.8,
                    height: screenWidth * 0.6,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                bottom: screenHeight * 0.1,
                top: screenWidth * 0.05,
              ),
              child: const CircularProgressIndicator(
                color: Color(0xFFFED36A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
