import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    // Mock Data with specific recommendations for each history item
    final List<Map<String, dynamic>> history = [
      {
        'id': 1,
        'date': 'Oct 24',
        'image': 'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?q=80&w=600&auto=format&fit=crop',
        'title': 'Modern Living Room',
        'recommendations': [
             {'name': 'Velvet Sofa', 'price': 'PKR 85,000', 'store': 'Habitt', 'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?q=80&w=1000&auto=format&fit=crop'},
             {'name': 'Gold Coffee Table', 'price': 'PKR 25,000', 'store': 'Interwood', 'image': 'https://images.unsplash.com/photo-1618220179428-22790b461013?q=80&w=1000&auto=format&fit=crop'},
        ]
      },
      {
        'id': 2,
        'date': 'Oct 22',
        'image': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4f9d?q=80&w=600&auto=format&fit=crop',
        'title': 'Cozy Reading Nook',
        'recommendations': [
             {'name': 'Wingback Chair', 'price': 'PKR 45,000', 'store': 'OLX', 'image': 'https://images.unsplash.com/photo-1580480055273-228ff5388ef8?q=80&w=1000&auto=format&fit=crop'},
             {'name': 'Floor Lamp', 'price': 'PKR 12,000', 'store': 'Daraz', 'image': 'https://images.unsplash.com/photo-1513506003013-1b63484f3cc6?q=80&w=1000&auto=format&fit=crop'},
        ]
      },
      {
        'id': 3,
        'date': 'Oct 20',
        'image': 'https://images.unsplash.com/photo-1595514020180-272e50339d1b?q=80&w=600&auto=format&fit=crop',
        'title': 'Industrial Bedroom',
         'recommendations': [
             {'name': 'Metal Bed Frame', 'price': 'PKR 35,000', 'store': 'Habitt', 'image': 'https://images.unsplash.com/photo-1505693416388-b034631ac0f3?q=80&w=1000&auto=format&fit=crop'},
        ]
      },
       {
        'id': 4,
        'date': 'Oct 18',
        'image': 'https://images.unsplash.com/photo-1560185893-a55cbc8c57e8?q=80&w=600&auto=format&fit=crop',
        'title': 'Minimalist Office',
         'recommendations': [
             {'name': 'Ergonomic Chair', 'price': 'PKR 28,000', 'store': 'Workiture', 'image': 'https://images.unsplash.com/photo-1505843490538-5133c6c7d0e1?q=80&w=1000&auto=format&fit=crop'},
             {'name': 'Floating Shelves', 'price': 'PKR 5,000', 'store': 'Daraz', 'image': 'https://images.unsplash.com/photo-1594620302200-9a762244a156?q=80&w=1000&auto=format&fit=crop'},
        ]
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("My Designs", style: GoogleFonts.outfit()),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {}, // Settings
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: history.length,
          itemBuilder: (context, index) {
            final item = history[index];
            return GestureDetector(
              onTap: () {
                // Open result view with mock data
                context.push('/result', extra: {
                  'original': item['image'],
                  'result': item['image'], // Ideally should be different, but using same for mock
                  'product': item['recommendations'][0], // Main one
                  'recommendations': item['recommendations']
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(item['image']),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black87],
                      stops: [0.6, 1.0],
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        item['date'],
                        style: GoogleFonts.outfit(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().scale(duration: 400.ms, delay: (100 * index).ms);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/lens'),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.camera_alt),
        label: Text("New Design", style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
