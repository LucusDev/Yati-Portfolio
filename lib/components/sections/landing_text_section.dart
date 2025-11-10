import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yati_portfolio/utils/app_color.dart';

class LandingTextSection extends StatelessWidget {
  final double scrollOffset;
  const LandingTextSection({super.key, required this.scrollOffset});

  double _calculateOpacity(double screenHeight) {
    final double startFadeOut = screenHeight * 0.3;
    final double endFadeOut = screenHeight * 0.9;

    if (scrollOffset < startFadeOut) {
      return 1.0;
    } else if (scrollOffset >= endFadeOut) {
      return 0.0;
    } else {
      final progress =
          (scrollOffset - startFadeOut) / (endFadeOut - startFadeOut);
      return 1.0 - progress;
    }
  }

  Color _calculateTextColorLerp(double screenHeight) {
    final offScreenPercentage = min(scrollOffset / (screenHeight * 0.7), 1.0);

    final textColor = Color.lerp(
        AppColors.secondaryColor, AppColors.accentColor, offScreenPercentage);
    return textColor!;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const double titleSize = 90;

    return AnimatedOpacity(
      opacity: _calculateOpacity(screenSize.height),
      duration: const Duration(milliseconds: 100),
      child: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Stack(
          children: [
            const Positioned(
              bottom: 360,
              left: 75,
              child: Text(
                'Welcome! You\'ve arrived at',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18,
                  fontFamily: 'Agrandir',
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'KHIN YATI',
                    style: TextStyle(
                      height: 1.2,
                      color: AppColors.whiteColor,
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Horizon',
                    ),
                  ),
                  const Text(
                    '        LIN LAI\'s',
                    style: TextStyle(
                      height: 1.2,
                      color: AppColors.whiteColor,
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.9,
                      fontFamily: 'Horizon',
                    ),
                  ),
                  Text(
                    'Portfolio',
                    style: TextStyle(
                      height: 1,
                      color: _calculateTextColorLerp(screenSize.height),
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.9,
                      fontFamily: 'Horizon',
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 70,
              right: 180,
              child: Text(
                "Connecting people, communication, and experiences with\npurpose and professionalism!",
                style: TextStyle(
                  height: 1.3,
                  color: AppColors.whiteColor,
                  fontSize: 18,
                  fontFamily: 'Agrandir',
                ),
              ),
            ),
            // Scroll Animation
            Positioned(
              bottom: 0,
              right: 60,
              child: Lottie.asset(
                'assets/animations/scroll.json',
                repeat: true,
                animate: true,
                height: 400,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
