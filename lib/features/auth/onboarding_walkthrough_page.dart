import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class OnboardingWalkthroughPage extends StatefulWidget {
  const OnboardingWalkthroughPage({super.key});

  @override
  State<OnboardingWalkthroughPage> createState() =>
      _OnboardingWalkthroughPageState();
}

class _OnboardingWalkthroughPageState extends State<OnboardingWalkthroughPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Welcome to Playschool',
      'desc':
          'The comprehensive app for school management, connecting parents, teachers, and admins seamlessly.',
      'image': 'https://cdn-icons-png.flaticon.com/512/3652/3652191.png',
    },
    {
      'title': 'Track Progress',
      'desc':
          'Monitor academic growth, health stats, and daily activities of your child in real-time.',
      'image': 'https://cdn-icons-png.flaticon.com/512/1081/1081040.png',
    },
    {
      'title': 'Stay Secure',
      'desc':
          'Advanced security features like Visitor Logs, Gate Passes, and encrypted data for peace of mind.',
      'image': 'https://cdn-icons-png.flaticon.com/512/2092/2092663.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {}, // Skip to login
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (idx) => setState(() => _currentPage = idx),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(_pages[index]['image']!, height: 250),
                        const SizedBox(height: 48),
                        Text(
                          _pages[index]['title']!,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.headingLarge(
                            isDarkMode,
                          ).copyWith(fontSize: 28),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _pages[index]['desc']!,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyLarge(
                            isDarkMode,
                          ).copyWith(color: AppColors.textSubLight),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => _buildDot(index, isDarkMode),
              ),
            ),

            const SizedBox(height: 48),

            Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                label: _currentPage == _pages.length - 1
                    ? 'Get Started'
                    : 'Next',
                onPressed: () {
                  if (_currentPage < _pages.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Navigating to Login...')),
                    );
                  }
                },
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index, bool isDarkMode) {
    bool isActive = index == _currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
