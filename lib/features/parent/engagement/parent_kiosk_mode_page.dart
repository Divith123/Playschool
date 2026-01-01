import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

import 'package:google_fonts/google_fonts.dart';

class ParentKioskModePage extends StatefulWidget {
  const ParentKioskModePage({super.key});

  @override
  State<ParentKioskModePage> createState() => _ParentKioskModePageState();
}

class _ParentKioskModePageState extends State<ParentKioskModePage> {
  // Simulating Kiosk Lock State
  bool _isLocked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Kiosk usually dark/immersive
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.monitor, size: 80, color: Colors.white),
              const SizedBox(height: 32),
              Text(
                'Self-Check-In Kiosk',
                style: GoogleFonts.lexend(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Please scan your parent QR code to check-in your child.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 48),

              // Scanner Placeholder
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 4),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_scanner,
                        size: 64,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Camera Active',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              if (_isLocked)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, color: Colors.white54, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Kiosk Mode Active. Exit requires Admin PIN.',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ],
                ),

              const SizedBox(height: 16),
              TextButton(
                onPressed: _showExitDialog,
                child: Text(
                  'Exit Kiosk Mode',
                  style: TextStyle(color: Colors.white30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Admin PIN Required'),
        content: TextField(
          decoration: InputDecoration(hintText: 'Enter 4-digit PIN'),
          obscureText: true,
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _isLocked = false);
              Navigator.pop(context); // Actually exit page
            },
            child: Text('Unlock'),
          ),
        ],
      ),
    );
  }
}
