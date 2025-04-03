// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'auth_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2500),
//     );
//
//     _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
//
//     _animationController.forward();
//
//     Timer(const Duration(milliseconds: 3000), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => const AuthScreen()),
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: isDarkMode
//                 ? [const Color(0xFF1A2151), const Color(0xFF0D1333)]
//                 : [const Color(0xFFE6F0FF), const Color(0xFFCCE0FF)],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AnimatedBuilder(
//                 animation: _animation,
//                 builder: (context, child) {
//                   return SizedBox(
//                     height: 100,
//                     width: 100,
//                     child: CustomPaint(
//                       painter: DropletPainter(
//                         fillPercentage: _animation.value,
//                         isDarkMode: isDarkMode,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 'AquaMinder',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: isDarkMode ? Colors.blue.shade200 : Colors.blue.shade800,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Because, every drop counts !!',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: isDarkMode ? Colors.blue.shade300 : Colors.blue.shade600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class DropletPainter extends CustomPainter {
//   final double fillPercentage;
//   final bool isDarkMode;
//
//   DropletPainter({required this.fillPercentage, required this.isDarkMode});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final outlinePaint = Paint()
//       ..color = isDarkMode ? Colors.blue.shade400 : Colors.blue.shade500
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;
//
//     final fillPaint = Paint()
//       ..color = isDarkMode ? Colors.blue.shade300 : Colors.blue.shade700
//       ..style = PaintingStyle.fill;
//
//     final path = Path();
//
//     // Draw droplet shape
//     path.moveTo(size.width * 0.5, 0);
//     path.quadraticBezierTo(
//         size.width * 0.1, size.height * 0.5,
//         size.width * 0.5, size.height
//     );
//     path.quadraticBezierTo(
//         size.width * 0.9, size.height * 0.5,
//         size.width * 0.5, 0
//     );
//
//     // Draw the outline
//     canvas.drawPath(path, outlinePaint);
//
//     // Create clipping path for the fill based on percentage
//     final fillPath = Path();
//     fillPath.moveTo(size.width * 0.5, size.height);
//     fillPath.lineTo(0, size.height);
//     fillPath.lineTo(0, size.height - (size.height * fillPercentage));
//     fillPath.lineTo(size.width, size.height - (size.height * fillPercentage));
//     fillPath.lineTo(size.width, size.height);
//     fillPath.close();
//
//     // Create the intersection of the droplet and the fill rectangle
//     final combinedPath = Path.combine(
//         PathOperation.intersect,
//         path,
//         fillPath
//     );
//
//     // Draw the fill
//     canvas.drawPath(combinedPath, fillPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant DropletPainter oldDelegate) {
//     return oldDelegate.fillPercentage != fillPercentage;
//   }
// }

import 'package:flutter/material.dart';
import 'dart:async';
import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fillAnimation;
  late Animation<double> _dropAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _fillAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeInOut),
      ),
    );

    _dropAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();

    Timer(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const AuthScreen()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [const Color(0xFF1A2151), const Color(0xFF0D1333)]
                : [const Color(0xFFE6F0FF), const Color(0xFFCCE0FF)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Stack(
                  children: [
                    // Tap
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return CustomPaint(
                            size: const Size(150, 50),
                            painter: TapPainter(
                              isDarkMode: isDarkMode,
                            ),
                          );
                        },
                      ),
                    ),

                    // Water Drop
                    Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      child: AnimatedBuilder(
                        animation: _dropAnimation,
                        builder: (context, child) {
                          return CustomPaint(
                            size: const Size(20, 30),
                            painter: WaterDropPainter(
                              progress: _dropAnimation.value,
                              isDarkMode: isDarkMode,
                            ),
                          );
                        },
                      ),
                    ),

                    // Water Droplet Container
                    Positioned(
                      bottom: 0,
                      left: 25,
                      right: 25,
                      child: AnimatedBuilder(
                        animation: _fillAnimation,
                        builder: (context, child) {
                          return SizedBox(
                            height: 100,
                            width: 100,
                            child: CustomPaint(
                              painter: DropletPainter(
                                fillPercentage: _fillAnimation.value,
                                isDarkMode: isDarkMode,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'AquaMinder',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.blue.shade200 : Colors.blue.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Because, every drop counts!',
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.blue.shade300 : Colors.blue.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TapPainter extends CustomPainter {
  final bool isDarkMode;

  TapPainter({required this.isDarkMode});

  @override
  void paint(Canvas canvas, Size size) {
    final tapPaint = Paint()
      ..color = isDarkMode ? Colors.blue.shade700 : Colors.blue.shade600
      ..style = PaintingStyle.fill;

    // Draw tap body
    final tapPath = Path();
    tapPath.moveTo(size.width * 0.4, 0);
    tapPath.lineTo(size.width * 0.6, 0);
    tapPath.lineTo(size.width * 0.6, size.height * 0.4);
    tapPath.lineTo(size.width * 0.4, size.height * 0.4);
    tapPath.close();
    canvas.drawPath(tapPath, tapPaint);

    // Draw tap spout
    final spoutPaint = Paint()
      ..color = isDarkMode ? Colors.blue.shade600 : Colors.blue.shade500
      ..style = PaintingStyle.fill;

    final spoutPath = Path();
    spoutPath.moveTo(size.width * 0.35, size.height * 0.4);
    spoutPath.lineTo(size.width * 0.65, size.height * 0.4);
    spoutPath.lineTo(size.width * 0.55, size.height * 0.6);
    spoutPath.lineTo(size.width * 0.45, size.height * 0.6);
    spoutPath.close();
    canvas.drawPath(spoutPath, spoutPaint);
  }

  @override
  bool shouldRepaint(covariant TapPainter oldDelegate) {
    return oldDelegate.isDarkMode != isDarkMode;
  }
}

class WaterDropPainter extends CustomPainter {
  final double progress;
  final bool isDarkMode;

  WaterDropPainter({required this.progress, required this.isDarkMode});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final dropPaint = Paint()
      ..color = isDarkMode ? Colors.blue.shade300 : Colors.blue.shade400
      ..style = PaintingStyle.fill;

    // Calculate drop position based on progress
    final dropY = size.height * 3 * progress; // Multiply by 3 to make it move further

    // Draw water drop
    final dropPath = Path();
    dropPath.moveTo(size.width * 0.5, dropY);
    dropPath.quadraticBezierTo(
        size.width * 0.4, dropY + 10,
        size.width * 0.5, dropY + 20
    );
    dropPath.quadraticBezierTo(
        size.width * 0.6, dropY + 10,
        size.width * 0.5, dropY
    );

    canvas.drawPath(dropPath, dropPaint);
  }

  @override
  bool shouldRepaint(covariant WaterDropPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isDarkMode != isDarkMode;
  }
}

class DropletPainter extends CustomPainter {
  final double fillPercentage;
  final bool isDarkMode;

  DropletPainter({required this.fillPercentage, required this.isDarkMode});

  @override
  void paint(Canvas canvas, Size size) {
    final outlinePaint = Paint()
      ..color = isDarkMode ? Colors.blue.shade400 : Colors.blue.shade500
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final fillPaint = Paint()
      ..color = isDarkMode ? Colors.blue.shade300 : Colors.blue.shade700
      ..style = PaintingStyle.fill;

    final path = Path();

    // Draw droplet shape
    path.moveTo(size.width * 0.5, 0);
    path.quadraticBezierTo(
        size.width * 0.1, size.height * 0.5,
        size.width * 0.5, size.height
    );
    path.quadraticBezierTo(
        size.width * 0.9, size.height * 0.5,
        size.width * 0.5, 0
    );

    // Draw the outline
    canvas.drawPath(path, outlinePaint);

    // Create clipping path for the fill based on percentage
    final fillPath = Path();
    fillPath.moveTo(size.width * 0.5, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.lineTo(0, size.height - (size.height * fillPercentage));
    fillPath.lineTo(size.width, size.height - (size.height * fillPercentage));
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    // Create the intersection of the droplet and the fill rectangle
    final combinedPath = Path.combine(
        PathOperation.intersect,
        path,
        fillPath
    );

    // Draw the fill
    canvas.drawPath(combinedPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant DropletPainter oldDelegate) {
    return oldDelegate.fillPercentage != fillPercentage ||
        oldDelegate.isDarkMode != isDarkMode;
  }
}