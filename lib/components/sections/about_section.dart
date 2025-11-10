import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yati_portfolio/utils/app_color.dart';

class AboutSection extends StatelessWidget {
  final double scrollOffset;
  const AboutSection({super.key, required this.scrollOffset});

  double _calculateOpacity(
    double screenHeight,
  ) {
    final double startFadeIn = screenHeight * 0.5;
    final double endFadeIn = screenHeight * 0.8;

    if (scrollOffset < startFadeIn) {
      return 0.0;
    } else if (scrollOffset >= endFadeIn) {
      return 1.0;
    } else {
      return (scrollOffset - startFadeIn) / (endFadeIn - startFadeIn);
    }
  }

  double _calculateSlideContainer(double screenHeight) {
    final offScreenPercentage = min(scrollOffset / (screenHeight * 0.9), 1.0);
    final easedProgress = Curves.easeInOut.transform(offScreenPercentage);
    final slideDistance = (-800 + easedProgress * 800).clamp(-800.0, -30.0);
    return slideDistance;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return AnimatedOpacity(
      opacity: _calculateOpacity(screenSize.height),
      duration: const Duration(milliseconds: 100),
      child: SizedBox(
        height: screenSize.height + 50,
        width: screenSize.width,
        child: Stack(
          children: [
            // Quote Text
            Positioned(
              bottom: 60,
              left: 370,
              child: _buildQuoteText(),
            ),
            // Slide Container
            Positioned(
              top: 248,
              left: _calculateSlideContainer(screenSize.height),
              child: Container(
                height: 120,
                width: 760,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            // About Content
            Container(
              padding: const EdgeInsets.only(left: 100, right: 150),
              height: screenSize.height,
              width: screenSize.width / 1.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello, I\'m',
                    style: TextStyle(
                      height: 1,
                      color: AppColors.whiteColor,
                      fontSize: 45,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Horizon',
                    ),
                  ),
                  const Text(
                    'Khin Yati Lin Lai',
                    style: TextStyle(
                      height: 1,
                      color: AppColors.primaryColor,
                      fontSize: 45,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Horizon',
                    ),
                  ),
                  const SizedBox(height: 20),
                  DefaultTextStyle(
                    style: GoogleFonts.lora(
                        color: const Color(0xFFA46E56),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          "I'm International Business (First Honor) Student!",
                          speed: const Duration(milliseconds: 60),
                          cursor: '|',
                        ),
                        TypewriterAnimatedText(
                          "I'm English Teacher!",
                          speed: const Duration(milliseconds: 60),
                          cursor: '|',
                        ),
                        TypewriterAnimatedText(
                          "I'm Event Organizer!",
                          speed: const Duration(milliseconds: 60),
                          cursor: '|',
                        ),
                        TypewriterAnimatedText(
                          "I'm Sales And Customer Service Specialist!",
                          speed: const Duration(milliseconds: 60),
                          cursor: '|',
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: AppColors.secondaryColor,
                    thickness: 4,
                    endIndent: 666,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'I enjoy working with people, connecting across cultures, and creating positive experiences in every environment I’m part of. I value communication, patience, teamwork, and understanding others these guide the way I collaborate and build relationships.',
                    style: TextStyle(
                      height: 1,
                      color: AppColors.textColor,
                      fontSize: 16,
                      letterSpacing: 1,
                      fontFamily: 'Agrandir',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteText() {
    return SizedBox(
      width: 800,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/icons/start_quote.png',
              color: AppColors.secondaryColor,
              height: 30,
              width: 30,
            ),
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "I’m always open to new ideas, new environments, and new challenges because\n that’s where real growth happens.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 18,
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
                fontFamily: 'Agrandir',
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'assets/icons/end_quote.png',
              color: AppColors.secondaryColor,
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
    );
  }
}
