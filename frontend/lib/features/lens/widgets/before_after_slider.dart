import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class BeforeAfterSlider extends StatefulWidget {
  final ImageProvider beforeImage;
  final ImageProvider afterImage;

  const BeforeAfterSlider({
    super.key,
    required this.beforeImage,
    required this.afterImage,
  });

  @override
  State<BeforeAfterSlider> createState() => _BeforeAfterSliderState();
}

class _BeforeAfterSliderState extends State<BeforeAfterSlider> {
  double _splitValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return Stack(
          children: [
            // Background (After Image - The Design)
            SizedBox(
              width: width,
              height: height,
                  child: Image(
                    image: widget.afterImage, 
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.black54, child: const Icon(Icons.broken_image, color: Colors.white)),
                  ),
            ),

            // Foreground (Before Image - Original)
            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: _splitValue,
                child: SizedBox(
                   width: width,
                   height: height,
                   child: Image(
                     image: widget.beforeImage, 
                     fit: BoxFit.cover,
                     errorBuilder: (context, error, stackTrace) => Container(color: Colors.black87, child: const Icon(Icons.broken_image, color: Colors.white)),
                   ),
                ),
              ),
            ),

            // Slider Handle
            Positioned(
              top: 0,
              bottom: 0,
              left: width * _splitValue - 1.5, // Center the line
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _splitValue = (details.localPosition.dx / width).clamp(0.0, 1.0);
                    // This logic needs to be relative to the widget, but Positioned/GestureDetector 
                    // inside Stack might be tricky with localPosition.
                    // Better approach: wrap the whole stack in GestureDetector.
                  });
                },
                child: Container(
                   width: 3, 
                   color: AppColors.accent,
                ),
              ),
            ),
             // Handle Cirle
            Positioned(
               top: height / 2 - 16,
               left: width * _splitValue - 16,
               child: Container(
                 width: 32, 
                 height: 32, 
                 decoration: BoxDecoration(
                   color: AppColors.accent,
                   shape: BoxShape.circle,
                   boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 4)]
                 ),
                 child: const Icon(Icons.code, color: Colors.black, size: 16), // Use arrows icon ideally
               ),
            ),
            
            // Interaction Area (Overlay) to catch drags anywhere
            Positioned.fill(
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _splitValue += details.delta.dx / width;
                    _splitValue = _splitValue.clamp(0.0, 1.0);
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
