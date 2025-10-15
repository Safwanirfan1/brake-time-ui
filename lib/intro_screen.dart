import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                            // Logo circle
                            // Container(
                            //   width: 72,
                            //   height: 72,
                            //   decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                            //   alignment: Alignment.center,
                            //   child: Text('B', style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.w600, color: Colors.white)),
                            // ),
                            
  Image.asset(
    'assets/logo.png', // ← apne logo ka correct path likhein
    width: 100,        // logo ka size adjust kar sakte ho
    height: 100,
    fit: BoxFit.contain,
  ),


                            const SizedBox(width: 18),

                            // text: fades in and types
                            Opacity(
                              opacity: _textFade.value,
                              child: DefaultTextStyle(
                                style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600, color: accent),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(visible),
                                    // invisible placeholder to keep width
                                    Text(hidden, style: TextStyle(color: accent.withOpacity(0))),
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
