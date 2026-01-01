import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/features/auth/login_page.dart';
import 'package:playschool/services/update_service.dart';
import 'package:ota_update/ota_update.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _checkAndNavigate();
  }

  Future<void> _checkAndNavigate() async {
    // Run animation and update check in parallel
    final results = await Future.wait([
      _controller.forward(),
      // Delay slightly to ensure animation is visible
      Future.delayed(const Duration(seconds: 2)),
      UpdateService().checkForUpdate(),
    ]);

    final updateInfo = results[2] as Map<String, dynamic>?;

    if (!mounted) return;

    if (updateInfo != null && updateInfo['updateAvailable'] == true) {
      _showUpdateDialog(updateInfo);
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _showUpdateDialog(Map<String, dynamic> updateInfo) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Update Available'),
        content: Text(
          'A new version ${updateInfo['latestVersion']} is available.\n\n${updateInfo['releaseNotes'] ?? ''}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _navigateToLogin();
            },
            child: const Text('Later'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _downloadUpdate(updateInfo['downloadUrl']);
            },
            child: const Text('Update Now'),
          ),
        ],
      ),
    );
  }

  void _downloadUpdate(String url) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return StreamBuilder<OtaEvent>(
              stream: UpdateService().downloadAndInstall(url),
              builder: (context, snapshot) {
                String status = 'Starting download...';
                double progress = 0.0;

                if (snapshot.hasData) {
                  final event = snapshot.data!;
                  status = event.status.toString().split('.').last;
                  if (event.value != null && event.value!.isNotEmpty) {
                    progress = (int.tryParse(event.value!) ?? 0) / 100.0;
                  }
                }

                if (snapshot.hasError) {
                  return AlertDialog(
                    title: const Text('Update Failed'),
                    content: Text('Error: ${snapshot.error}'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          _navigateToLogin();
                        },
                        child: const Text('Skip & Continue'),
                      ),
                    ],
                  );
                }

                return AlertDialog(
                  title: const Text('Updating...'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(status),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(value: progress),
                      const SizedBox(height: 8),
                      Text('${(progress * 100).toInt()}%'),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF2bee6c);
    const backgroundDark = Color(0xFF102216);

    return Scaffold(
      backgroundColor: backgroundDark,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: primary.withOpacity(0.5),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        size: 64,
                        color: primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Playschool',
                      style: GoogleFonts.lexend(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      'Management System',
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(0.7),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
