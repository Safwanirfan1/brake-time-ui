import 'dart:async';

import 'package:flutter/material.dart';
import 'home_screen.dart';

/// Clean OTP verification screen (5-digit)
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  static const int _initialSeconds = 120; // 2 minutes
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  Timer? _timer;
  int _secondsLeft = _initialSeconds;

  final Color _darkGreen = const Color(0xFF006400);
  final Color _lightGreen = const Color.fromARGB(255, 26, 219, 58);

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(5, (_) => TextEditingController());
    _focusNodes = List.generate(5, (_) => FocusNode());
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNodes[0].requestFocus());
    _startTimer();
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 0) {
        t.cancel();
        setState(() {});
        return;
      }
      setState(() => _secondsLeft -= 1);
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = _initialSeconds);
    _startTimer();
  }

  String _formattedTime() {
    final minutes = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  bool _isOtpComplete() => _controllers.every((c) => c.text.trim().isNotEmpty);

  void _onVerify() {
    if (!_isOtpComplete()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter the full 5-digit code')));
      return;
    }
  // Navigate to HomeScreen and replace the current route
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  Widget _buildPinField(int index) {
    return SizedBox(
      width: 56,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.black26)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.black87, width: 2)),
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            if (index > 0) _focusNodes[index - 1].requestFocus();
            return;
          }
          final ch = value.replaceAll(RegExp('[^0-9]'), '');
          if (ch.isEmpty) return;
          if (ch.length > 1) {
            // Paste handling: distribute across fields
            for (int i = 0; i < ch.length && (index + i) < _controllers.length; i++) {
              _controllers[index + i].text = ch[i];
            }
            final next = (index + ch.length) < _controllers.length ? index + ch.length : _controllers.length - 1;
            _focusNodes[next].requestFocus();
          } else {
            _controllers[index].text = ch;
            if (index + 1 < _focusNodes.length) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus();
            }
          }
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.topCenter,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontFamily: 'Roboto'),
                    children: [
                      TextSpan(text: 'Brake', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: _darkGreen)),
                      TextSpan(text: 'Time', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: _lightGreen)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height:28),

              Expanded(
                child: Center(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                   
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(child: Text('Verification Code', style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500))),
                        const SizedBox(height: 19),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (i) => Padding(padding: const EdgeInsets.symmetric(horizontal: 6.0), child: _buildPinField(i))),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: screenWidth * 0.8,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _isOtpComplete() ? _onVerify : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('Verify', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          children: [
                            const SizedBox(height: 6),
                            Text("Didn't receive the code?", style: TextStyle(fontSize: 14, color: Colors.black54)),
                            TextButton(
                              onPressed: () {
                                for (final c in _controllers) c.clear();
                                _focusNodes[0].requestFocus();
                                _resetTimer();
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Verification code resent')));
                              },
                              child: const Text('Resend Code', style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(height: 6),
                            Text('Code expires in ${""}', style: TextStyle(fontSize: 13, color: Colors.black54)),
                            const SizedBox(height: 4),
                            Text(_formattedTime(), style: const TextStyle(fontSize: 13, color: Colors.black54)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

