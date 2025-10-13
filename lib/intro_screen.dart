import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnim; // 0 -> 1 over 1.5s
  late final Animation<double> _morphAnim; // 0 -> 1 over 1s

  static const Color darkGreen = Color(0xFF006400);
  static const Color lightGreen = Color(0xFF32CD32);

  // sizing
  static const double _fontSize = 96.0;
  static const double _targetSpacing = 140.0; // final spacing between B and T

  @override
  void initState() {
    super.initState();
    // total 3.0 seconds: 1.5s expand, 1.0s morph, 0.5s hold
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _expandAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut), // 1.5s
    );

    _morphAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.8333333, curve: Curves.easeInOut), // 1s
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // after hold (included in controller duration), navigate to login
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _spacing() {
    // interpolation for spacing during expand phase
    return _expandAnim.value * _targetSpacing;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final btOpacity = (1.0 - _morphAnim.value).clamp(0.0, 1.0);
            final fullOpacity = (_morphAnim.value).clamp(0.0, 1.0);

            return Stack(
              alignment: Alignment.center,
              children: [
                // Image expanding (replaces the BT glyphs)
                Opacity(
                  opacity: btOpacity,
                  child: SizedBox(
                    width: _fontSize + _spacing(),
                    height: _fontSize,
                    child: Center(
                      child: Container(
                        // border so the area is visible during debugging
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          'assets/logo.png',
                          width: _fontSize * (0.6 + 0.4 * _expandAnim.value),
                          height: _fontSize * (0.6 + 0.4 * _expandAnim.value),
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            // show a visible error placeholder when asset can't load
                            return Container(
                              width: _fontSize * 0.8,
                              height: _fontSize * 0.8,
                              color: Colors.red.shade100,
                              child: Center(
                                  child: Text('Image failed to load', style: TextStyle(color: Colors.red.shade900, fontSize: 12))),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                // BrakeTime morph/reveal
                Opacity(
                  opacity: fullOpacity,
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Brake',
                          style: TextStyle(
                            color: darkGreen,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Time',
                          style: TextStyle(
                            color: lightGreen,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
