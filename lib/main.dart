import 'package:firstproject/intro_screen.dart';
import 'package:firstproject/login_screen.dart';
import 'package:firstproject/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:firstproject/forgot_password_screen.dart';
import 'package:firstproject/reset_password_screen.dart';
import 'package:firstproject/signupscreen.dart';
import 'package:firstproject/check_access.dart'; 




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroScreen(),
        '/login': (context) => const LoginScreen(),
        '/otp': (context) => const OtpVerificationScreen(),
        '/forgot': (context) => const ForgotPasswordScreen(),
        '/reset': (context) => const ResetPasswordScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/check': (context) => const SignupAccessCheckScreen(), 
         

      },
    );
  }
}