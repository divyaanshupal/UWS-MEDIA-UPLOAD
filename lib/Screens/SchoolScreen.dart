import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:uws/Screens/OtherScreen.dart';
import 'package:uws/widgets/drawer.dart';

void openUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
    throw 'Could not launch $url';
  }
}

class SchoolSelectionScreen extends StatelessWidget {
  const SchoolSelectionScreen({super.key});

  final Map<String, String> schoolDriveLinks = const {
    'HS BAHADURPUR':
        'https://drive.google.com/drive/folders/1H65r7YLkx4q_9rFE2DZbFACmfvQFFKpd',
    'MS RANI TALAV':
        'https://drive.google.com/drive/folders/1GvyFVeUgpChSQY-R9Ii0JT0qkJcnoqMe',
    'MS BABUPUR':
        'https://drive.google.com/drive/folders/1H65r7YLkx4q_9rFE2DZbFACmfvQFFKpd',
    'MS JHURKURIYA':
        'https://drive.google.com/drive/folders/1WtOSrsVYP9IqRFo3cYdWaZ86cT1bH2Pj',
    'MS ARYA TOLA':
        'https://drive.google.com/drive/folders/1H250RWRL1bbATd9ReheeszPdgyaEji7P',
    'GIRLS HIGH SCHOOL':
        'https://drive.google.com/drive/folders/1Eh52oiYGVmZO6izgoN3KWit_TjPcGHbc',
    'MS MEERACHAK':
        'https://drive.google.com/drive/folders/1HIL-WGYmRuv0kBska8q_mOFngqxdvnJg',
    'BOYS SCHOOL SABOUR':
        'https://drive.google.com/drive/folders/1lQLz2oPjEiHR9KHqucx7eJDGrGSXOr59',
  };

  @override
  Widget build(BuildContext context) {
    final schools = schoolDriveLinks.keys.toList();
    final screenWidth = MediaQuery.of(context).size.width;

    return MainLayout(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2C3E50),
              Color(0xFF3498DB),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: ModernGridPainter(),
              ),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 600 ? screenWidth * 0.2 : 24,
                    vertical: 40,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(20),
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
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  Color(0xFF1E293B),
                                  Color(0xFF334155),
                                ],
                              ).createShader(bounds),
                              child: const Text(
                                'Select Your School',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      ...schools.asMap().entries.map(
                            (entry) => TweenAnimationBuilder<double>(
                              duration: Duration(
                                  milliseconds: 500 + (entry.key * 100)),
                              tween: Tween(begin: 50.0, end: 0.0),
                              builder: (context, value, child) {
                                return Transform.translate(
                                  offset: Offset(0, value),
                                  child: Opacity(
                                    opacity: 1 - (value / 50),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Transform.scale(
                                          scale: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFF1E293B),
                                                  Color(0xFF334155),
                                                ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF1E293B)
                                                      .withOpacity(0.2),
                                                  blurRadius: 15,
                                                  offset: const Offset(0, 8),
                                                ),
                                              ],
                                            ),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                onTap: () => openUrl(
                                                    schoolDriveLinks[
                                                        entry.value]!),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 20,
                                                    horizontal: 24,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          entry.value,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      const Icon(
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
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 800),
                        tween: Tween(begin: 50.0, end: 0.0),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, value),
                            child: Opacity(
                              opacity: 1 - (value / 50),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF1E293B),
                                        Color(0xFF334155),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF1E293B)
                                            .withOpacity(0.2),
                                        blurRadius: 15,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        GoRouter.of(context).go('/programs');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 24,
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Others',
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

// Modern Grid Background
class ModernGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF64748B).withOpacity(0.03)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = const Color(0xFF64748B).withOpacity(0.07)
      ..style = PaintingStyle.fill;

    const spacing = 40.0;
    const dotSize = 2.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
