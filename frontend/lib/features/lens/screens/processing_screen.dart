import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import 'dart:io';

class ProcessingScreen extends StatefulWidget {
  final String imagePath;
  const ProcessingScreen({super.key, required this.imagePath});

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  int _currentStep = 0;
  final List<String> _steps = [
    "Analyzing Room Geometry...",
    "Scanning Style Context...",
    "Searching Local Inventory...",
    "Visualizing Upgrade...",
  ];

  @override
  void initState() {
    super.initState();
    _startProcessing();
  }

  void _startProcessing() async {
    for (int i = 0; i < _steps.length; i++) {
      if (!mounted) return;
      setState(() => _currentStep = i);
      await Future.delayed(const Duration(seconds: 3)); // Simulate work
    }
    
    if (mounted) {
      // Done, navigate to result
      // Mock Data
      context.pushReplacement('/result', extra: {
        'original': widget.imagePath,
        'result': 'assets/mock/room_result.jpg', // Placeholder
        'product': {
            'name': 'Velvet Accent Chair',
            'price': 'PKR 45,000',
            'store': 'Habitt'
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // If imagePath is 'assets...', use Asset, else File
    final bool isAsset = widget.imagePath.startsWith('assets/');
    ImageProvider imageProvider;
    if (isAsset && widget.imagePath.isNotEmpty) {
      // in real app we'd have assets, fail safe to network or color
       imageProvider = const NetworkImage("https://images.unsplash.com/photo-1540518614846-7eded433c457?q=80&w=2903&auto=format&fit=crop");
    } else if (widget.imagePath.isNotEmpty) {
       imageProvider = FileImage(File(widget.imagePath));
    } else {
       imageProvider = const NetworkImage("https://images.unsplash.com/photo-1540518614846-7eded433c457?q=80&w=2903&auto=format&fit=crop");
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image (Blurred)
          Image(
            image: imageProvider,
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          
          // Content
          Center(
            child: Container(
              margin: const EdgeInsets.all(32),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(0.9),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.primary, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ]
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated Loader
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
                      strokeWidth: 6,
                    ),
                  ),
                  const Gap(24),
                  
                  // Text
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      _steps[_currentStep],
                      key: ValueKey(_currentStep),
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const Gap(8),
                  Text(
                    "Powered by Gemini 3",
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  )
                ],
              ),
            ).animate().fadeIn().scale(),
          ),
        ],
      ),
    );
  }
}
