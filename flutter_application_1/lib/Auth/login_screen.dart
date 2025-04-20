import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_1/Auth/signup_screen.dart';
import 'package:flutter_application_1/task_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      final response = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);

      if (response.user == null) {
        throw 'Login failed. Please try again.';
      }

      // Navigate to task screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TaskScreen()),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Logo
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: Center(
                  child: Image.asset(
                    'assets/images/top_splash.png',
                    width: screenWidth * 1.22,
                    height: screenWidth * 0.28,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Welcome Text
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.05,
                ),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Email Field
              _buildTextField(
                label: 'Email Address',
                controller: emailController,
                icon: Icons.email,
                hint: 'example@email.com',
                isPassword: false,
              ),

              // Password Field
              _buildTextField(
                label: 'Password',
                controller: passwordController,
                icon: Icons.lock,
                hint: 'Enter your password',
                isPassword: true,
              ),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: screenWidth * 0.05,
                    top: screenHeight * 0.005,
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),

              // Log In Button
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.025,
                ),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFED36A),
                    minimumSize: Size(double.infinity, screenHeight * 0.06),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text(
                          'Log In',
                          style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              // Or continue with
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: const Text(
                  '— Or continue with —',
                  style: TextStyle(color: Colors.grey),
                ),
              ),

              // Google Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: OutlinedButton(
                  onPressed: () {}, // TODO: implement Google sign in
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    minimumSize: Size(double.infinity, screenHeight * 0.06),
                    backgroundColor: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Google',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Sign Up Prompt
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.03,
                  bottom: screenHeight * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFFFED36A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    required bool isPassword,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.015,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextField(
            controller: controller,
            obscureText: isPassword ? _obscurePassword : false,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.white),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    )
                  : null,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFF2A2A2A),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
