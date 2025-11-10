import 'dart:math';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:yati_portfolio/components/sections/landing_image_section.dart';
import 'package:yati_portfolio/components/sections/record_section.dart';
import 'package:yati_portfolio/utils/app_color.dart';
import 'components/sections/about_section.dart';
import 'components/sections/landing_text_section.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  double _currentScrollOffset = 0.0;
  DateTime _lastUpdateTime = DateTime.now();

  void _updateScrollOffset(double newOffset) {
    final now = DateTime.now();

    if (mounted &&
        _currentScrollOffset != newOffset &&
        now.difference(_lastUpdateTime).inMilliseconds > 16) {
      setState(() {
        _currentScrollOffset = newOffset;
        _lastUpdateTime = now;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          // Background Circle
          _buildCircleAnimation(screenSize),

          // Main Content
          ScrollTransformView(
            children: [
              ScrollTransformItem(
                builder: (scrollOffset) {
                  if (_currentScrollOffset != scrollOffset) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _updateScrollOffset(scrollOffset);
                    });
                  }

                  return LandingImageSection(scrollOffset: scrollOffset);
                },
                offsetBuilder: (scrollOffset) {
                  final offScreenPercentage =
                      min(scrollOffset / (screenSize.height * 0.7), 1.0);
                  // Distance between top and right edge of the screen
                  final heightShrinkingAmount =
                      screenSize.height * 0.2 * offScreenPercentage;
                  final widthShrinkingAmount =
                      screenSize.width * 0.61 * offScreenPercentage;

                  final bool isMoving = scrollOffset >= screenSize.height * 0.8;
                  final double onScreenOffset =
                      scrollOffset + heightShrinkingAmount / 1.97;

                  return Offset(
                    widthShrinkingAmount / 2.3,
                    !isMoving
                        ? onScreenOffset
                        : onScreenOffset -
                            (scrollOffset - screenSize.height * 0.8),
                  );
                },
              ),
              ScrollTransformItem(
                builder: (scrollOffset) {
                  return Stack(
                    children: [
                      Transform.translate(
                        offset: Offset(0, -screenSize.height),
                        child: LandingTextSection(scrollOffset: scrollOffset),
                      ),
                      AboutSection(scrollOffset: scrollOffset),
                    ],
                  );
                },
              ),
              ScrollTransformItem(
                builder: (scrollOffset) {
                  return RecordSection(scrollOffset: scrollOffset);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleAnimation(Size screenSize) {
    return Positioned(
      top: -400 - (_currentScrollOffset / (screenSize.height * 0.7)) * 400,
      right: -230 - (_currentScrollOffset / (screenSize.height * 0.7)) * 600,
      child: AnimatedScale(
        scale: 1.0 - (_currentScrollOffset / (screenSize.height * 0.7)) * 0.4,
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: 2000,
          width: 2000,
          decoration: const BoxDecoration(
            color: AppColors.secondaryColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
