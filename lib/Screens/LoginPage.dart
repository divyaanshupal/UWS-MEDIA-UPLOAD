import 'dart:async';
import 'dart:ui'; // Needed for ImageFilter

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uws/Screens/SchoolScreen.dart';

//import 'package:flutter/foundation.dart'; // Import foundation for kIsWeb

//import 'dart:html' as html;
import 'package:url_launcher/url_launcher.dart';
import 'package:uws/widgets/drawer.dart'; // Import url_launcher package

void openUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
    throw 'Could not launch $url';
  }
}

class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({super.key});

  @override
  State<LandingPageScreen> createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen>
    with SingleTickerProviderStateMixin {
  final bool _isTextVisible = true;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  // Add these variables for typing animation
  String get _textToType => 'Unnati Welfare Society';
  String _typedText = '';
  bool _showCursor = true;
  Timer? _cursorTimer;
  Timer? _typingTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Setup animations
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Start animations
    _controller.forward();

    // Start typing animation after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _startTypingAnimation();
    });

    // Setup cursor blinking
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _showCursor = !_showCursor;
        });
      }
    });
  }

  void _startTypingAnimation() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_currentIndex < _textToType.length) {
        setState(() {
          _typedText = _textToType.substring(0, _currentIndex + 1);
          _currentIndex++;
        });
      } else {
        _typingTimer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _cursorTimer?.cancel();
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MainLayout(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Modern Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2C3E50), // Deep blue-grey
                  Color(0xFF3498DB), // Bright blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Animated Pattern Overlay
          Positioned.fill(
            child: CustomPaint(
              painter: GridPatternPainter(),
            ),
          ),

          // Main Content with Glass Effect
          SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      width: screenWidth < 600 ? screenWidth * 0.9 : 450,
                      constraints: BoxConstraints(
                        maxHeight: screenHeight * 0.7,
                      ),
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Logo with shadow and animation
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Hero(
                                tag: 'logo',
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/unnati_logo.jpg',
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Welcome Text with Typing Animation
                            Column(
                              children: [
                                const Text(
                                  'Welcome to',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Text(
                                    //   _typedText,
                                    //   textAlign: TextAlign.center,
                                    //   style: const TextStyle(
                                    //     fontSize: 28,
                                    //     fontWeight: FontWeight.bold,
                                    //     color: Colors.white,
                                    //     letterSpacing: 1,
                                    //   ),
                                    // ),
                                    // if (_currentIndex < _textToType.length ||
                                    //     _showCursor)
                                    //   Text(
                                    //     '|',
                                    //     style: TextStyle(
                                    //       fontSize: 28,
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.white
                                    //           .withOpacity(_showCursor ? 1 : 0),
                                    //     ),
                                    //   ),

                                    //animated text kit usage for typewriter effect
                                    SizedBox(
                                      width: 250.0,
                                      child: DefaultTextStyle(
                                        style: const TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        child: AnimatedTextKit(
                                          repeatForever: true,
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                              'Unnati Welfare Society',
                                              speed: const Duration(
                                                  milliseconds: 70),
                                              cursor: '|',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 50),

                            // Modern Proceed Button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  GoRouter.of(context).go('/schools');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF2C3E50),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Get Started',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_forward_rounded),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Grid Pattern
class GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    double spacing = 30;

    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
