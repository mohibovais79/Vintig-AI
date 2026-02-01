import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/screens/email_auth_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/onboarding/screens/style_selection_screen.dart';
import '../../features/lens/screens/camera_screen.dart';
import '../../features/lens/screens/processing_screen.dart';
import '../../features/lens/screens/result_screen.dart';
import '../../features/gallery/screens/gallery_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/auth/email',
        builder: (context, state) => const EmailAuthScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const StyleSelectionScreen(),
      ),
      GoRoute(path: '/lens', builder: (context, state) => const CameraScreen()),
      GoRoute(
        path: '/processing',
        builder: (context, state) {
          final imagePath = state.extra as String?;
          return ProcessingScreen(imagePath: imagePath ?? '');
        },
      ),
      GoRoute(
        path: '/result',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          return ResultScreen(
            originalImage: data?['original'] ?? '',
            resultImage: data?['result'] ?? '',
            product: data?['product'] ?? {},
            recommendations: data?['recommendations'],
          );
        },
      ),
      GoRoute(
        path: '/gallery',
        builder: (context, state) => const GalleryScreen(),
      ),
    ],
  );
});
