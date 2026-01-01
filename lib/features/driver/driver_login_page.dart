import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/features/driver/driver_trip_log_page.dart';
import 'package:playschool/widgets/primary_button.dart';

class DriverLoginPage extends StatefulWidget {
  const DriverLoginPage({super.key});

  @override
  State<DriverLoginPage> createState() => _DriverLoginPageState();
}

class _DriverLoginPageState extends State<DriverLoginPage> {
  final _vehicleIdController = TextEditingController();
  final _pinController = TextEditingController();
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() => _isLoading = true);

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (_vehicleIdController.text.isNotEmpty &&
        _pinController.text.isNotEmpty) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DriverTripLogPage()),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter Vehicle ID and PIN'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? Colors.white : AppColors.textMainLight,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.directions_bus_filled,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Driver Login',
                style: AppTextStyles.headingLarge(isDarkMode),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your vehicle details to start',
                style: AppTextStyles.bodyMedium(
                  isDarkMode,
                ).copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 48),

              // Vehicle ID
              TextField(
                controller: _vehicleIdController,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Vehicle Number',
                  prefixIcon: const Icon(Icons.pin_outlined),
                  filled: true,
                  fillColor: isDarkMode
                      ? AppColors.surfaceDark
                      : AppColors.surfaceLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // PIN
              TextField(
                controller: _pinController,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 4,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Driver PIN',
                  prefixIcon: const Icon(Icons.lock_outline),
                  filled: true,
                  fillColor: isDarkMode
                      ? AppColors.surfaceDark
                      : AppColors.surfaceLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  counterText: "",
                ),
              ),
              const SizedBox(height: 32),

              PrimaryButton(
                label: 'Start Shift',
                onPressed: _handleLogin,
                isLoading: _isLoading,
                width: double.infinity,
                icon: Icons.key,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
