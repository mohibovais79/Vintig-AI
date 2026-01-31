import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import '../../../core/theme/app_colors.dart';
import '../widgets/before_after_slider.dart';

class ResultScreen extends StatelessWidget {
  final String originalImage;
  final String resultImage;
  final Map<String, dynamic>? product; // Legacy
  final List<Map<String, dynamic>>? recommendations;

  const ResultScreen({
    super.key,
    required this.originalImage,
    required this.resultImage,
    this.product,
    this.recommendations,
  });

  ImageProvider _getImageProvider(String path) {
    if (path.isEmpty) return const AssetImage('assets/images/placeholder.jpg'); // Fallback
    if (path.startsWith('http')) return NetworkImage(path);
    if (path.startsWith('assets/')) {
        // Fallback or explicit asset
        return AssetImage(path); 
        // Note: In real app, check if asset exists or use errorBuilder in the widget text
    }
    return FileImage(File(path));
  }

  @override
  Widget build(BuildContext context) {
    // Mock Product Recommendations (in a real app, this comes from the backend)
    // Use passed recommendations if available, else fallback to mock
    final List<Map<String, dynamic>> displayDocs = recommendations ?? [
      if (product != null) product!,
       // ... existing fallbacks or maybe just empty or specific defaults if no product passed
       // actually, let's keep the hardcoded ones as a default 'demo' set if nothing passed
      {
        'name': 'Nordic Floor Lamp',
        'price': 'PKR 12,500',
        'store': 'Habitt',
        'image': 'https://images.unsplash.com/photo-1507473888900-52a11b75ffe5?q=80&w=1000&auto=format&fit=crop'
      },
      {
        'name': 'Geometric Rug',
        'price': 'PKR 8,000',
        'store': 'Carpet center',
        'image': 'https://images.unsplash.com/photo-1575414003591-ece8d0416c7a?q=80&w=1000&auto=format&fit=crop'
      },
       {
        'name': 'Abstract Wall Art',
        'price': 'PKR 5,500',
        'store': 'Daraz',
        'image': 'https://images.unsplash.com/photo-1582555172866-fc2ee0219a50?q=80&w=1000&auto=format&fit=crop'
      }
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // 1. Comparison Area (Takes most space)
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                BeforeAfterSlider(
                  beforeImage: _getImageProvider(originalImage),
                  afterImage: _getImageProvider(resultImage),
                ),
                
                // Overlay Header
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         CircleAvatar(
                           backgroundColor: Colors.black45,
                           child: IconButton(
                             icon: const Icon(Icons.close, color: Colors.white),
                             onPressed: () => context.pop(),
                           ),
                         ),
                         Container(
                           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                           decoration: BoxDecoration(
                             color: Colors.black54,
                             borderRadius: BorderRadius.circular(30)
                           ),
                           child: Row(
                             children: [
                               const Icon(Icons.compare, color: Colors.white, size: 16),
                               const Gap(8),
                               Text(
                                 "Compare Mode", 
                                 style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w500)
                               ),
                             ],
                           ),
                         ),
                         CircleAvatar(
                           backgroundColor: Colors.black45,
                           child: IconButton(
                             icon: const Icon(Icons.save_alt, color: Colors.white),
                             onPressed: () {
                               ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(content: Text("Design Saved to Gallery!"))
                               );
                             },
                           ),
                         ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Recommendations Panel
          Container(
            color: AppColors.surface, // Distinct background
            padding: const EdgeInsets.only(top: 24, bottom: 32, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shop the Look",
                        style: GoogleFonts.outfit(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      Text(
                        "${displayDocs.length} Items",
                        style: GoogleFonts.outfit(
                          color: AppColors.textSecondary
                        ),
                      )
                    ],
                  ),
                ),
                
                const Gap(16),

                // Horizontal Scrollable List
                SizedBox(
                  height: 140, // Fixed height for cards
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: displayDocs.length,
                    separatorBuilder: (_, __) => const Gap(16),
                    itemBuilder: (context, index) {
                      final item = displayDocs[index];
                      return _ProductCard(item: item);
                    },
                  ),
                ),
              ],
            ),
          ).animate().slideY(begin: 0.2, duration: 500.ms, curve: Curves.easeOut),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const _ProductCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item['image'] ?? '',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80, 
                height: 80, 
                color: AppColors.surfaceLight,
                child: const Icon(Icons.image_not_supported, color: Colors.white54),
              ),
            ),
          ),
          const Gap(16),
          
          // Info & Action
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['name'] ?? 'Product',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item['store'] ?? 'Store',
                  style: GoogleFonts.outfit(
                    color: AppColors.textSecondary,
                    fontSize: 12
                  ),
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['price'] ?? '',
                      style: GoogleFonts.outfit(
                        color: AppColors.accent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),
                    ),
                    InkWell(
                      onTap: () {}, // Link to store
                      child: Container(
                         padding: const EdgeInsets.all(6),
                         decoration: const BoxDecoration(
                           color: AppColors.primary,
                           shape: BoxShape.circle,
                         ),
                         child: const Icon(Icons.arrow_forward, size: 14, color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
