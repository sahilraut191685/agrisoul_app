import 'package:agrisoul2/components/my_textfield.dart';
import 'package:agrisoul2/components/squares_tile.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Navigate to HomePage
  void signUserIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  // Guest navigation
  void continueAsGuest(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌈 Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFa8e063), Color(0xFF56ab2f)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Content
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // 🌱 Animated Title
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(seconds: 2),
                    child: Text(
                      "🌱 AgriSoul",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 6,
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // 🟢 Glassmorphic login box
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white30, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Lock icon
                        const Icon(Icons.lock_person_outlined,
                            size: 70, color: Colors.white),

                        const SizedBox(height: 20),

                        // Username
                        MyTextfield(
                          controller: usernameController,
                          hindText: "Username",
                          obscureText: false,
                        ),

                        const SizedBox(height: 15),

                        // Password
                        MyTextfield(
                          controller: passwordController,
                          hindText: "Password",
                          obscureText: true,
                        ),

                        const SizedBox(height: 10),

                        // Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 🔘 Sign In + Guest Buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => signUserIn(context),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(18),
                                  backgroundColor: Colors.green.shade700,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 8,
                                  shadowColor: Colors.black54,
                                ),
                                icon: const Icon(Icons.login,
                                    color: Colors.white),
                                label: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => continueAsGuest(context),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(18),
                                  backgroundColor: Colors.orange.shade600,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 8,
                                  shadowColor: Colors.black54,
                                ),
                                icon: const Icon(Icons.person_outline,
                                    color: Colors.white),
                                label: const Text(
                                  "Guest",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // Divider
                        Row(
                          children: [
                            const Expanded(
                                child:
                                    Divider(thickness: 1, color: Colors.white)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text("Or continue with",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.9))),
                            ),
                            const Expanded(
                                child:
                                    Divider(thickness: 1, color: Colors.white)),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // 🌍 Social Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SquaresTile(imagePath: 'lib/images/gooogle.jpg'),
                            SizedBox(width: 15),
                            
                            
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Register Now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Not a member?",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(width: 5),
                      Text(
                        "Register Now",
                        style: TextStyle(
                          color: Color.fromARGB(255, 23, 29, 147),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
