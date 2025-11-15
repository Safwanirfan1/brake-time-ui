// import 'package:flutter/material.dart';
// // import 'otp_screen.dart';
// import 'home_screen.dart';


// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _showPassword = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Center(
//             child: SingleChildScrollView(
//                 child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
                  
//                   Image.asset(
//                        'assets/logo.png', // ← yahan apne logo ka path likhein
//                           width: 120,        // aap apne design ke hisab se size adjust kar sakte hain
//                           height: 120,
//                         ),

//                   const SizedBox(height: 0),
//                   //  const Text('BrakeTime', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 11, 150, 11),)),
//                   RichText(
//                     text: const TextSpan(
//                       children: [
//                         TextSpan(
//                           text: 'Brake',
//                           style: TextStyle(
//                             fontSize: 48,
//                             fontWeight: FontWeight.bold,
//                             // color: Color(0xFF32CD32),
//                             color: Color(0xFF006400), // Light Green
//                           ),
//                         ),
//                         TextSpan(
//                           text: 'Time',
//                           style: TextStyle(
//                             fontSize: 48,
//                             fontWeight: FontWeight.bold,
//                             //color: Color(0xFF006400),
//                             color: Color(0xFF32CD32), // Dark Green
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 32),
                  
//                   TextField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       border: const OutlineInputBorder(),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Color(0xFF006400)),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Color(0xFF006400), width: 2),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   TextField(
//                     controller: _passwordController,
//                     obscureText: !_showPassword,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       border: const OutlineInputBorder(),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Color(0xFF006400)),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Color(0xFF006400), width: 2),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
//                         onPressed: () {
//                           setState(() => _showPassword = !_showPassword);
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.resolveWith((states) {
//                           return null; // gradient handled below
//                         }),
//                         padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//                       ),
//                       onPressed: () {
//                           final email = _emailController.text.trim();
//                           final pass = _passwordController.text;
//                           if (email.isEmpty || pass.isEmpty) {
//                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill email and password')));
//                             return;
//                           }

                          
//                           Navigator.of(context).pushReplacement(PageRouteBuilder(
//                             transitionDuration: const Duration(milliseconds: 500),
//                             pageBuilder: (context, animation, secondaryAnimation) {
//                               return FadeTransition(
//                                 opacity: animation,
//                                 child: const HomeScreen(), // 👈 login ke baad directly home screen
//                               );
//                             },
//                           ));

//                         },
//                       child: Ink(
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(colors: [Color.fromARGB(255, 14, 116, 44), Color.fromARGB(255, 26, 219, 58)]),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Container(
//                           alignment: Alignment.center,
//                           child: const Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pushNamed('/forgot'); // ✅ Updated route
//                     },
//                     child: const Text(
//                       'Forgot Password?',
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 0, 0, 0),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Don't have an account? "),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pushNamed('/check');
//                         },
//                         child: const Text(
//                           'Sign Up',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF006400),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 📱 Responsive measures
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? size.width * 0.25 : 24,
              vertical: isWide ? 40 : 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🟢 App Logo
                Image.asset(
                  'assets/logo.png',
                  width: isWide ? 160 : 120,
                  height: isWide ? 160 : 120,
                ),

                const SizedBox(height: 10),

                // 🟩 Brand Text
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Brake',
                        style: TextStyle(
                          fontSize: isWide ? 56 : 42,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF006400),
                        ),
                      ),
                      TextSpan(
                        text: 'Time',
                        style: TextStyle(
                          fontSize: isWide ? 56 : 42,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF32CD32),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // 📧 Email field
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF006400)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF006400), width: 2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 🔒 Password field
                TextField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF006400)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF006400), width: 2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() => _showPassword = !_showPassword);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // 🔘 Login button with gradient
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(4),
                    ),
                    onPressed: () {
                      final email = _emailController.text.trim();
                      final pass = _passwordController.text;
                      if (email.isEmpty || pass.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill email and password'),
                          ),
                        );
                        return;
                      }

                      // ✅ Navigate to HomeScreen
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          transitionDuration:
                              const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return FadeTransition(
                              opacity: animation,
                              child: const HomeScreen(),
                            );
                          },
                        ),
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 14, 116, 44),
                            Color.fromARGB(255, 26, 219, 58),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: isWide ? 18 : 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 🔁 Forgot Password
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/forgot');
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: isWide ? 17 : 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // 🧍 Signup Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: isWide ? 17 : 14),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/check');
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isWide ? 17 : 14,
                          color: const Color(0xFF006400),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
