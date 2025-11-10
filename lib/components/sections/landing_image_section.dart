import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:yati_portfolio/widgets/rect_to_oval_clipper.dart';

class LandingImageSection extends StatelessWidget {
  final double scrollOffset;
  const LandingImageSection({super.key, required this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final offScreenPercentage =
        min(scrollOffset / (screenSize.height * 0.7), 1.0);
    print(scrollOffset);

    return ClipPath(
      clipper: RectToOvalClipper(
        progress: offScreenPercentage,
        rotationAngle: 15 * pi / 180,
      ),
      child: Stack(
        children: [
          // Landing Image
          Image.asset(
            'assets/images/my_profile.jpg',
            height: screenSize.height -
                (screenSize.height * 0.2 * offScreenPercentage),
            width: screenSize.width -
                (screenSize.width * 0.7 * offScreenPercentage),
            fit: BoxFit.cover,
          ),
          // Glassmorphism Container
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 3.0 - (3.0 * offScreenPercentage),
                sigmaY: 3.0 - (3.0 * offScreenPercentage),
              ),
              child: Container(
                height: screenSize.height -
                    (screenSize.height * 0.2 * offScreenPercentage),
                width: screenSize.width -
                    (screenSize.width * 0.7 * offScreenPercentage),
                decoration: BoxDecoration(
                  color: Color.lerp(
                    Colors.black.withOpacity(0.4),
                    Colors.transparent,
                    offScreenPercentage,
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
