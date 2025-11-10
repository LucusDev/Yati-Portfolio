import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yati_portfolio/utils/app_color.dart';

class RecordSection extends StatefulWidget {
  final double scrollOffset;
  const RecordSection({super.key, required this.scrollOffset});

  @override
  State<RecordSection> createState() => _RecordSectionState();
}

class _RecordSectionState extends State<RecordSection>
    with TickerProviderStateMixin {
  bool isClicked = false;
  bool _showLottie = true;

  double _calculateTextReveal({required double begin, required double end}) {
    if (widget.scrollOffset < begin) return 0.0;
    if (widget.scrollOffset >= end) return 1.0;

    final double linearProgress = (widget.scrollOffset - begin) / (end - begin);
    return Curves.easeOutCubic.transform(linearProgress);
  }

  void _toggleClicked() {
    setState(() {
      isClicked = !isClicked;
      if (isClicked) {
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) {
            setState(() {
              _showLottie = false;
            });
          }
        });
      } else {
        _showLottie = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height,
      width: screenSize.width,
      color: AppColors.secondaryColor,
      child: Stack(
        children: [
          // Top Left Folder
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            top: 360,
            left: isClicked ? 400 : 713,
            child: _buildFolder(
                'assets/icons/yellow_folder.png', 'My Professional Journey'),
          ),
          // Bottom Left Folder
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            top: isClicked ? 540 : 400,
            left: isClicked ? 440 : 713,
            child: _buildFolder(
                'assets/icons/peach_folder.png', 'Educational Backgrounds'),
          ),
          // Top Right Folder
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            top: 360,
            right: isClicked ? 400 : 713,
            child: _buildFolder('assets/icons/orange_folder.png',
                'Achievements & Certifications'),
          ),
          // Bottom Right Folder
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            top: isClicked ? 540 : 400,
            right: isClicked ? 440 : 713,
            child: _buildFolder(
                'assets/icons/purple_folder.png', 'Events & Campaigns'),
          ),
          // Bottom Center Folder
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            top: isClicked ? 640 : 400,
            left: 720,
            child: _buildFolder('assets/icons/black_folder.png', 'Activities'),
          ),
          // Record Content
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                _buildTextAnimaion(
                  text: 'FOLDERS OF MY LIFE',
                  progress: _calculateTextReveal(
                    begin: screenSize.height * 1.0,
                    end: screenSize.height * 2.2,
                  ),
                  textStyle: const TextStyle(
                    color: AppColors.accentColor,
                    fontSize: 60,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Borsok',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Each folder captures a chapter of my journey\n— explore my professional path, milestones & the skills I’ve built along the way',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Agrandir',
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/icons/mackbook.png',
                    height: 400,
                    width: 400,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 240,
            left: 610,
            child: Text(
              'Tap the laptop to explore my works and profiles!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Agrandir',
              ),
            ),
          ),
          // Click Animation
          Positioned(
            top: 210,
            left: 570,
            child: GestureDetector(
              onTap: () {
                _toggleClicked();
              },
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _showLottie ? 0.4 : 0.0,
                child: Lottie.asset(
                  'assets/animations/click.json',
                  repeat: _showLottie,
                  animate: _showLottie,
                  height: 400,
                  width: 400,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextAnimaion({
    required String text,
    required double progress,
    required TextStyle textStyle,
  }) {
    return ClipRRect(
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: progress,
        child: Transform.translate(
          offset: Offset(0, 10 * (1.0 - progress)),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildFolder(String icon, String label) {
    return SizedBox(
      width: 110,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 14,
                fontFamily: 'Agrandir',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
