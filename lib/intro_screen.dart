import 'dart:ui';

import 'package:flutter/material.dart';
// using system fonts (no google_fonts) — keep styles simple

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _moveLeft; // 0..1
  late final Animation<double> _textFade; // 0..1
  late final Animation<double> _typeProgress; // 0..1
  late final Animation<double> _bgFade; // background switch to white

  static const Color accent = Color(0xFF00C853);
  final String _title = 'Brake Time';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000));

    // Start: 0-1000ms idle with logo center. 1000-2000ms move left. text fades+types while moving.
    _moveLeft = CurvedAnimation(parent: _controller, curve: const Interval(0.33, 0.66, curve: Curves.easeInOut));
    _textFade = CurvedAnimation(parent: _controller, curve: const Interval(0.53, 0.86, curve: Curves.easeIn));
    _typeProgress = CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.95, curve: Curves.easeOut));
    _bgFade = CurvedAnimation(parent: _controller, curve: const Interval(0.86, 1.0, curve: Curves.easeIn));

    _controller.forward();

    _controller.addStatusListener((s) {
      if (s == AnimationStatus.completed) {
        // optional: navigate to login after a short delay
        Future.delayed(const Duration(milliseconds: 400), () {
          Navigator.of(context).pushReplacementNamed('/login');
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final width = MediaQuery.of(context).size.width;
          // move from center (0) to left offset (-width*0.32)
          final dx = lerpDouble(0, -width * 0.10, _moveLeft.value) ?? 0;

          final revealCount = (_typeProgress.value * _title.length).clamp(0, _title.length).toInt();
          final visible = _title.substring(0, revealCount);
          final hidden = _title.substring(revealCount);

          // background: start dark (#0D0D0D) then fade to white
          final bgColor = Color.lerp(const Color.fromARGB(255, 255, 255, 255), Colors.white, _bgFade.value)!;

          return Container(
            color: bgColor,
            child: SafeArea(
              child: Stack(
                children: [
                  // centered area where logo begins
                  Positioned.fill(
                    child: Transform.translate(
                      offset: Offset(dx, 0),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                           
                            
                            Image.asset(
                              'assets/logo.png', // ← apne logo ka correct path likhein
                              width: 60,        // logo ka size adjust kar sakte ho
                              height: 60,
                              fit: BoxFit.contain,
                            ),


                            const SizedBox(width: 18),
                            Opacity(
                             opacity: _textFade.value,
                              child: RichText(
                               text: TextSpan(
                                  style: const TextStyle(
                                   fontSize: 40,
                                   fontWeight: FontWeight.w600,
                                   ),
                             children: [
                                   TextSpan(
                                     text: visible.contains('Brake')
                                      ? visible.substring(0, visible.indexOf('Brake') + 5)
                                     : visible,
                                       style: const TextStyle(color: Color(0xFF006400)), // Dark green for 'Brake'
                                  ),
                           if (visible.length > 5)
                               TextSpan(
                                   text: visible.substring(5),
                             style: const TextStyle(color: Color(0xFF00C853)), // Light green for 'Time'
                      ),
                             ],
                            ),
                            ),
                           ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
