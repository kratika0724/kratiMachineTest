import 'package:flutter/material.dart';

import 'CoffeeHomeScreen.dart';

class CoffeeLoginScreen extends StatelessWidget {
  const CoffeeLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image10.png"), // Figma background
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Overlay for dim effect
            Container(color: Colors.black.withOpacity(0.6)),

            // Main content
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      Image.asset(
                        "assets/images/Group7.png",
                        width: 100,
                        fit: BoxFit.cover,
                      ),

                      const SizedBox(height: 32),

                      // const Text(
                      //   "Welcome to Login",
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 28,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      //
                      // const SizedBox(height: 48),

                      // Email Field
                      _buildTextField("E-mail Address"),

                      const SizedBox(height: 16),

                      // Password Field
                      _buildTextField("Password", isPassword: true),

                      const SizedBox(height: 16),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Color(0xFFD4A574)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Sign in Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CoffeeHomeScreen(),));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4A574),
                            foregroundColor: const Color(0xFF5A3E2B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                      Image.asset("assets/images/Group10.png"),
                      const SizedBox(height: 32),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.facebook, color: Colors.white, size: 32),
                          Icon(Icons.g_mobiledata,
                              color: Colors.white, size: 32),
                          Icon(Icons.alternate_email,
                              color: Colors.white, size: 32),
                        ],
                      ),

                      const SizedBox(height: 40),

                      Image.asset("assets/images/donthave.png"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }
}
