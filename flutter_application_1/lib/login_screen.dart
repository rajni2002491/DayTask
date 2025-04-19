import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Column(
          children: [
            // Top section with logo
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.01),
              child: Center(
                child: Image.asset(
                  'assets/images/top_splash.png',
                  width: screenWidth * 1.22,
                  height: screenWidth * 0.28,
                ),
              ),
            ),
            // Add your login form here
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
