import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class StyleSelectionScreen extends StatefulWidget {
  const StyleSelectionScreen({super.key});

  @override
  State<StyleSelectionScreen> createState() => _StyleSelectionScreenState();
}

class _StyleSelectionScreenState extends State<StyleSelectionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // State
  String? _selectedStyle;
  double _budget = 100000; // Default 100k PKR
  final TextEditingController _locationController = TextEditingController(text: "Karachi");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _currentPage > 0 
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _pageController.previousPage(duration: 300.ms, curve: Curves.easeInOut);
              },
            )
          : null,
        title: Text(
          "Setup Profile (${_currentPage + 1}/3)",
          style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Disable swipe
              onPageChanged: (page) => setState(() => _currentPage = page),
              children: [
                _buildStyleStep(),
                _buildBudgetStep(),
                _buildLocationStep(),
              ],
            ),
          ),
          
          // Navigation Bar
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage < 2) {
                    _pageController.nextPage(duration: 300.ms, curve: Curves.easeInOut);
                  } else {
                    // Save and Go to Lens
                    context.go('/lens');
                  }
                },
                child: Text(_currentPage == 2 ? "Get Started" : "Next"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepTitle(String title, String subtitle) {
    return Column(
      children: [
        Text(
          title, 
          style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)
        ),
        const Gap(8),
        Text(
          subtitle, 
          style: GoogleFonts.outfit(fontSize: 14, color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const Gap(32),
      ],
    );
  }

  // STEP 1: STYLE
  Widget _buildStyleStep() {
    final styles = [
      {'name': 'Modern', 'icon': Icons.apartment},
      {'name': 'Boho', 'icon': Icons.nature_people},
      {'name': 'Industrial', 'icon': Icons.factory},
      {'name': 'Classical', 'icon': Icons.museum},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStepTitle("Choose Your Vibe", "Select the aesthetic that matches your dream space."),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: styles.length,
              itemBuilder: (context, index) {
                final style = styles[index];
                final isSelected = _selectedStyle == style['name'];
                
                return GestureDetector(
                  onTap: () => setState(() => _selectedStyle = style['name'] as String),
                  child: AnimatedContainer(
                    duration: 200.ms,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary.withOpacity(0.2) : AppColors.surface,
                      border: Border.all(
                        color: isSelected ? AppColors.primary : Colors.transparent, 
                        width: 2
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          style['icon'] as IconData, 
                          size: 48, 
                          color: isSelected ? AppColors.accent : AppColors.textSecondary
                        ),
                        const Gap(16),
                        Text(
                          style['name'] as String,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().scale(duration: 400.ms, delay: (100 * index).ms);
              },
            ),
          ),
        ],
      ),
    );
  }

  // STEP 2: BUDGET
  Widget _buildBudgetStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           _buildStepTitle("What's your Budget?", "We'll find real items within this price range."),
           
           Container(
             padding: const EdgeInsets.all(24),
             decoration: BoxDecoration(
               color: AppColors.surface,
               borderRadius: BorderRadius.circular(24),
             ),
             child: Column(
               children: [
                 Text(
                   "PKR ${_budget.toInt()}",
                   style: GoogleFonts.outfit(
                     fontSize: 36, 
                     fontWeight: FontWeight.bold,
                     color: AppColors.accent,
                   ),
                 ),
                 const Gap(8),
                 Text("Estimated Total Cost", style: TextStyle(color: AppColors.textSecondary)),
                 
                 const Gap(24),
                 
                 Slider(
                   value: _budget,
                   min: 5000,
                   max: 500000, // 500k
                   divisions: 100,
                   onChanged: (val) => setState(() => _budget = val),
                 ),
                 
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("5k", style: TextStyle(color: AppColors.textSecondary)),
                       Text("500k", style: TextStyle(color: AppColors.textSecondary)),
                     ],
                   ),
                 )
               ],
             ),
           ).animate().fadeIn().slideY(begin: 0.1),
        ],
      ),
    );
  }

  // STEP 3: LOCATION
  Widget _buildLocationStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStepTitle("Where are we shopping?", "Local inventory availability depends on your city."),
          
          TextField(
            controller: _locationController,
            decoration: InputDecoration(
              hintText: "Enter City (e.g. Karachi)",
              prefixIcon: const Icon(Icons.location_on, color: AppColors.primary),
              suffixIcon: IconButton(
                icon: const Icon(Icons.my_location, color: AppColors.accent),
                onPressed: () {
                   setState(() => _locationController.text = "Karachi");
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text("Location detected: Karachi"))
                   );
                },
              ),
            ),
          ).animate().fadeIn().slideX(begin: -0.1),
          
          const Gap(16),
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.textHint.withOpacity(0.3))
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 20, color: AppColors.textSecondary),
                const Gap(12),
                Expanded(
                  child: Text(
                    "We currently support finding inventory in Karachi, Pakistan via Habitt and OLX.",
                    style: GoogleFonts.outfit(color: AppColors.textSecondary, fontSize: 13),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms),
        ],
      ),
    );
  }
}
