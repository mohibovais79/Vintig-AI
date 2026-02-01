import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.background,
                  Color(0xFF1A1A2E), // Slightly purple tint
                  AppColors.background,
                ],
              ),
            ),
          ),

          // ambient glow 1
          Positioned(
            top: -100,
            left: -100,
            child:
                Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withOpacity(
                          0.2,
                        ), // Keeping color
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.2),
                            blurRadius: 100,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scale(
                      duration: 2000.ms,
                      begin: const Offset(1, 1),
                      end: const Offset(1.2, 1.2),
                    ),
          ),

          // ambient glow 2
          Positioned(
            bottom: -50,
            right: -50,
            child:
                Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accent.withOpacity(0.15),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accent.withOpacity(0.15),
                            blurRadius: 100,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scale(
                      duration: 2500.ms,
                      begin: const Offset(1, 1),
                      end: const Offset(1.5, 1.5),
                    ),
          ),

          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo / Title
                  Icon(Icons.auto_awesome, size: 64, color: AppColors.accent)
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .slideY(begin: -0.5, end: 0),

                  const Gap(24),

                  Text(
                    "VINTIG AI",
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(duration: 800.ms, delay: 200.ms),

                  const Gap(8),

                  Text(
                    "Redesign your space with reality.",
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(duration: 800.ms, delay: 400.ms),

                  const Gap(48),

                  // Login Buttons
                  SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Mock login -> Go to Onboarding
                            context.push('/onboarding');
                          },
                          icon: const Icon(
                            Icons.g_mobiledata,
                            size: 28,
                          ), // Placeholder for Google Icon
                          label: const Text("Continue with Google"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 600.ms)
                      .slideY(begin: 0.5, end: 0),

                  const Gap(16),

                  SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            context.push('/auth/email');
                          },
                          icon: const Icon(Icons.email_outlined),
                          label: const Text("Continue with Email"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                              color: AppColors.surfaceLight,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            textStyle: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 700.ms)
                      .slideY(begin: 0.5, end: 0),

                  const Gap(32),

                  Text(
                    "Powered by Gemini 3",
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ).animate().fadeIn(delay: 1000.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
