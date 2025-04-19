import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

import 'package:uws/Screens/SchoolScreen.dart';

class Otherscreen extends StatelessWidget {
  const Otherscreen({Key? key}) : super(key: key);

  final Map<String, String> schoolDriveLinks = const {
    'Akshar':
        'https://drive.google.com/drive/folders/1qCE_JdBK0IqKDc8TFYaNzEd5xcejBD74',
    'Netritva':
        'https://drive.google.com/drive/folders/1GrkBAsgipGOroMQr9CdLIskwHkcatiKU',
    'Events':
        'https://drive.google.com/drive/folders/1uOpP6CYy4xpt3hC_pwZJAUhaLo5gP9BH',
    'Meets':
        'https://drive.google.com/drive/folders/1s5X7znewRuY6lrrMin5_f970fhEVd0IK',
        
  };

  bool isMobile() {
  // Checks if the user is on a mobile device by examining the user agent.
  final userAgent = html.window.navigator.userAgent.toLowerCase();
  return userAgent.contains("mobi");
}

bool isWeb() {
  // Checks if the app is running in a web environment.
  return identical(0, 0.0); // This checks if the platform is web
}

Future<void> _openDriveLink(String url) async {
  if (isMobile()) {
    // If on mobile, open in external application
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  } else if (isWeb()) {
    // If on the web, open in a new browser tab
    html.window.open(url, "_blank");
  } else {
    throw 'Unsupported platform';
  }
}

  @override
  Widget build(BuildContext context) {
    final schools = schoolDriveLinks.keys.toList();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
             Color(0xFF2C3E50),  // Deep blue-grey
             Color(0xFF3498DB), 
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background Pattern
            Positioned.fill(
              child: CustomPaint(
                painter: ModernGridPainter(),
              ),
            ),

            // Main Content
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 600 ? screenWidth * 0.2 : 24,
                    vertical: 40,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      
                      // Header Section
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Color(0xFF1E293B),
                                  Color(0xFF334155),
                                ],
                              ).createShader(bounds),
                              child: Text(
                                'Select Other Programs',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  //color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 40),

                      // School Buttons List
                      ...schools.asMap().entries.map(
                        (entry) => TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 500 + (entry.key * 100)),
                          tween: Tween(begin: 50.0, end: 0.0),
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, value),
                              child: Opacity(
                                opacity: 1 - (value / 50),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: TweenAnimationBuilder(
                                      duration: Duration(milliseconds: 200),
                                      tween: Tween<double>(begin: 1, end: 1),
                                      builder: (context, double scale, child) {
                                        return Transform.scale(
                                          scale: scale,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFF1E293B),
                                                  Color(0xFF334155),
                                                ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xFF1E293B).withOpacity(0.2),
                                                  blurRadius: 15,
                                                  offset: Offset(0, 8),
                                                ),
                                              ],
                                            ),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(20),
                                                onTap: () => _openDriveLink(
                                                    schoolDriveLinks[entry.value]!),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 20,
                                                    horizontal: 24,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          entry.value,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.white,
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward,
                                                        color: Colors.white70,
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      
                      
                      // Others Button
                      TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 800),
                        tween: Tween(begin: 50.0, end: 0.0),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, value),
                            child: Opacity(
                              opacity: 1 - (value / 50),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF1E293B),
                                        Color(0xFF334155),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF1E293B).withOpacity(0.2),
                                        blurRadius: 15,
                                        offset: Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        // 👇 Navigate to the next screen
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SchoolSelectionScreen(), // Replace with your screen
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 24,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              'DigiXplore',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white70,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),
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
}

// Modern Grid Pattern Painter
class ModernGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF64748B).withOpacity(0.03)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = Color(0xFF64748B).withOpacity(0.07)
      ..style = PaintingStyle.fill;

    final spacing = 40.0;
    final dotSize = 2.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
