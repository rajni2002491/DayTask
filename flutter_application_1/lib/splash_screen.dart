import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
            // Top section with logo
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
            ), // Center section with container and pana image
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(20),
                    ),
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
            ), // Bottom section with button
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                bottom: screenHeight * 0.1,
                top: screenWidth * 0.05,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFED36A),
                  minimumSize: Size(double.infinity, screenHeight * 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Let's Go",
                  style: TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
