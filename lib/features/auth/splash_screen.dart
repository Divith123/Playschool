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
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Version: ${updateInfo['latestVersion']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(updateInfo['releaseNotes'] ?? 'No release notes available'),
            ],
          ),
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
            onPressed: () async {
              Navigator.pop(ctx);

              // Check permissions first
              final updateService = UpdateService();
              final hasPermissions = await updateService.requestPermissions();

              if (!hasPermissions && mounted) {
                // Show permission explanation
                await showDialog(
                  context: context,
                  builder: (permCtx) => AlertDialog(
                    title: const Text('Permissions Required'),
                    content: const Text(
                      'To install updates, please enable:\n\n'
                      '• Storage access\n'
                      '• Install from unknown sources\n\n'
                      'The app will try to update, but you may need to manually install if permissions are denied.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(permCtx);
                          _downloadUpdate(updateInfo['downloadUrl']);
                        },
                        child: const Text('Continue'),
                      ),
                    ],
                  ),
                );
              } else {
                _downloadUpdate(updateInfo['downloadUrl']);
              }
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
                String status = 'Preparing update...';
                double progress = 0.0;
                bool hasError = false;
                String errorMessage = '';
                bool showManualInstructions = false;

                if (snapshot.hasData) {
                  final event = snapshot.data!;

                  // Handle different status types
                  switch (event.status) {
                    case OtaStatus.DOWNLOADING:
                      status = 'Downloading...';
                      progress =
                          (int.tryParse(event.value ?? '0') ?? 0) / 100.0;
                      break;
                    case OtaStatus.INSTALLING:
                      status = 'Installing...';
                      progress = 1.0;
                      break;
                    case OtaStatus.INSTALLATION_DONE: // Was completed
                      status =
                          'Update completed! You may need to manually install.';
                      progress = 1.0;
                      showManualInstructions = true;
                      break;
                    case OtaStatus
                        .INSTALLATION_ERROR: // Was failed (using INSTALLATION_ERROR as general fail)
                      hasError = true;
                      errorMessage = event.value ?? 'Update failed';
                      showManualInstructions = true;
                      break;
                    case OtaStatus.PERMISSION_NOT_GRANTED_ERROR:
                      hasError = true;
                      errorMessage =
                          'Permissions required. Please enable storage and installation permissions in app settings.';
                      showManualInstructions = true;
                      break;
                    default:
                      status = event.status.toString().split('.').last;
                      if (event.value != null && event.value!.isNotEmpty) {
                        progress = (int.tryParse(event.value!) ?? 0) / 100.0;
                      }
                  }
                }

                if (snapshot.hasError || hasError) {
                  return FutureBuilder<String>(
                    future: UpdateService().getInstallationInstructions(url),
                    builder: (context, instructionsSnapshot) {
                      final instructions =
                          instructionsSnapshot.data ??
                          'Loading instructions...';

                      return AlertDialog(
                        title: const Text('Update Issue'),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                snapshot.hasError
                                    ? 'Error: ${snapshot.error}'
                                    : errorMessage,
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Manual installation required:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(instructions),
                              const SizedBox(height: 8),
                              const Text(
                                'Note: After manual installation, you may need to restart the app.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              _navigateToLogin();
                            },
                            child: const Text('Skip & Continue'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              // Try again
                              _downloadUpdate(url);
                            },
                            child: const Text('Try Again'),
                          ),
                        ],
                      );
                    },
                  );
                }

                return AlertDialog(
                  title: const Text('Updating App'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(status, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(value: progress, minHeight: 8),
                      const SizedBox(height: 8),
                      Text('${(progress * 100).toInt()}%'),
                      if (progress > 0 && progress < 1)
                        const SizedBox(height: 8),
                      if (progress > 0 && progress < 1)
                        const Text(
                          'Please do not close the app',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      if (showManualInstructions)
                        FutureBuilder<String>(
                          future: UpdateService().getInstallationInstructions(
                            url,
                          ),
                          builder: (context, instructionsSnapshot) {
                            if (instructionsSnapshot.hasData) {
                              return Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    'Next steps:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '1. Check your notifications\n2. Tap the downloaded file\n3. Install when prompted',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                    ],
                  ),
                  actions: [
                    if (progress == 0)
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          _navigateToLogin();
                        },
                        child: const Text('Cancel'),
                      ),
                    if (progress == 1.0)
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          _navigateToLogin();
                        },
                        child: const Text('Continue'),
                      ),
                  ],
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
                            color: primary.withValues(alpha: 0.5),
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
                        color: Colors.white.withValues(alpha: 0.7),
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
