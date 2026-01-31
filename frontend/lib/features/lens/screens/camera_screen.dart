import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }
  
  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        _controller = CameraController(_cameras![0], ResolutionPreset.high);
        await _controller!.initialize();
        if (mounted) {
          setState(() => _isCameraInitialized = true);
        }
      }
    } catch (e) {
      debugPrint("Camera Error: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (!_isCameraInitialized || _controller == null) {
      // Fake it for emulator/simulator
      context.push('/processing', extra: 'assets/mock/room_original.jpg');
      return;
    }
    
    try {
      final image = await _controller!.takePicture();
      if(mounted) context.push('/processing', extra: image.path);
    } catch (e) {
       debugPrint("Capture Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 64),
               const SizedBox(height: 16),
               Text("Loading Camera...", style: GoogleFonts.outfit(color: Colors.white)),
               const SizedBox(height: 32),
               ElevatedButton(
                  onPressed: _takePicture, 
                  child: const Text("Use Mock Image (Simulator)")
               )
             ]
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Camera Preview
          CameraPreview(_controller!),
          
          // 2. Overlays (Guidance)
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white, size: 32),
                        onPressed: () => context.go('/'),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Point at a room corner",
                          style: GoogleFonts.outfit(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.flash_off, color: Colors.white, size: 32),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                
                // 3. Shutter Deck
                Container(
                  padding: const EdgeInsets.only(bottom: 32, top: 16),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black87, Colors.transparent],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.photo_library, color: Colors.white, size: 32),
                        onPressed: () {
                           context.push('/gallery');
                        },
                      ),
                      
                      // Shutter Button
                      GestureDetector(
                        onTap: _takePicture,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            color: Colors.white24,
                          ),
                          child: Container(
                             margin: const EdgeInsets.all(4),
                             decoration: const BoxDecoration(
                               shape: BoxShape.circle,
                               color: Colors.white,
                             ),
                          ),
                        ),
                      ).animate().scale(duration: 200.ms, curve: Curves.easeInOut),
                      
                      IconButton(
                        icon: const Icon(Icons.flip_camera_ios, color: Colors.white, size: 32),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
