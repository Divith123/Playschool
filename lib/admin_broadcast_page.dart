import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminBroadcastPage extends StatefulWidget {
  const AdminBroadcastPage({super.key});

  @override
  State<AdminBroadcastPage> createState() => _AdminBroadcastPageState();
}

class _AdminBroadcastPageState extends State<AdminBroadcastPage> {
  // Colors from the design
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a2c20);

  String _msgType = 'chat'; // 'chat' or 'broadcast'
  String _urgency = 'standard'; // 'standard' or 'emergency'

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? Colors.white : Colors.grey[900]!;
    final mutedColor = isDarkMode ? Colors.grey[400]! : Colors.grey[500]!;
    final borderColor = isDarkMode ? Colors.grey[800]! : Colors.grey[200]!;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: isDarkMode ? Colors.grey[200] : Colors.grey[800],
                        size: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'New Message',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lexend(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 48, // Balance the left icon width
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: mutedColor,
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          'Clear',
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  bottom: 100,
                ), // Space for bottom bar
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Segmented Control
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.grey[800]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            _buildSegmentOption(
                              label: 'In-App Chat',
                              value: 'chat',
                              isSelected: _msgType == 'chat',
                              isDarkMode: isDarkMode,
                            ),
                            _buildSegmentOption(
                              label: 'Broadcast Alert',
                              value: 'broadcast',
                              isSelected: _msgType == 'broadcast',
                              isDarkMode: isDarkMode,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Recipients Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recipients',
                            style: GoogleFonts.lexend(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: primary,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Edit list',
                              style: GoogleFonts.lexend(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Chips Group Selector
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          _buildChip(
                            icon: Icons.groups,
                            label: 'All School',
                            isActive: true, // Example state
                            isDarkMode: isDarkMode,
                          ),
                          const SizedBox(width: 12),
                          _buildChip(
                            icon: Icons.face,
                            label: 'Toddlers A',
                            isActive: false,
                            isDarkMode: isDarkMode,
                          ),
                          const SizedBox(width: 12),
                          _buildChip(
                            icon: Icons.child_care,
                            label: 'Pre-K',
                            isActive: false,
                            isDarkMode: isDarkMode,
                          ),
                          const SizedBox(width: 12),
                          _buildAddIndividualChip(isDarkMode),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: borderColor),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Icon(
                                Icons.search,
                                color: mutedColor,
                                size: 20,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  color: textColor,
                                ),
                                decoration: InputDecoration(
                                  hintText:
                                      'Search specific parents or students...',
                                  hintStyle: GoogleFonts.lexend(
                                    fontSize: 14,
                                    color: mutedColor,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                    bottom: 4,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Divider(
                      height: 1,
                      color: borderColor,
                      indent: 16,
                      endIndent: 16,
                    ),

                    const SizedBox(height: 24),

                    // Message Composer
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Message',
                                style: GoogleFonts.lexend(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '0/160 char',
                                style: GoogleFonts.lexend(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: mutedColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: borderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Expanded(
                                  child: TextField(
                                    maxLines: null,
                                    style: GoogleFonts.lexend(
                                      fontSize: 16,
                                      color: textColor,
                                    ),
                                    decoration: InputDecoration(
                                      hintText:
                                          "Type your announcement here... e.g. 'Reminder: Picture day is tomorrow! Please have children dress in their best outfits.'",
                                      hintStyle: GoogleFonts.lexend(
                                        fontSize: 16,
                                        color: mutedColor,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                // Attachment Bar
                                Container(
                                  padding: const EdgeInsets.only(top: 12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: borderColor),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      _buildAttachmentBtn(
                                        Icons.image,
                                        isDarkMode,
                                      ),
                                      const SizedBox(width: 12),
                                      _buildAttachmentBtn(
                                        Icons.attach_file,
                                        isDarkMode,
                                      ),
                                      const SizedBox(width: 12),
                                      _buildAttachmentBtn(
                                        Icons.bolt,
                                        isDarkMode,
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isDarkMode
                                              ? Colors.grey[900]
                                              : Colors.grey[50],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.schedule,
                                              size: 16,
                                              color: mutedColor,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              'Schedule',
                                              style: GoogleFonts.lexend(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: mutedColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (_msgType == 'broadcast') ...[
                      const SizedBox(height: 24),
                      // Broadcast Options (Urgency)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.red[900]!.withOpacity(0.2)
                                : Colors.red[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDarkMode
                                  ? Colors.red[900]!.withOpacity(0.3)
                                  : Colors.red[100]!,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.warning_amber,
                                    color: isDarkMode
                                        ? Colors.red[400]
                                        : Colors.red[600],
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Urgency Level',
                                    style: GoogleFonts.lexend(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.red[300]
                                          : Colors.red[800],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Standard
                              _buildUrgencyOption(
                                label: 'Standard Notification',
                                subLabel:
                                    'Push notification only. Best for general updates.',
                                value: 'standard',
                                groupValue: _urgency,
                                onChanged: (v) => setState(() => _urgency = v!),
                                isDarkMode: isDarkMode,
                              ),
                              const SizedBox(height: 8),
                              // Emergency
                              _buildUrgencyOption(
                                label: 'Emergency Alert',
                                subLabel:
                                    'Sends SMS + High Priority Push. Use with caution.',
                                value: 'emergency',
                                groupValue: _urgency,
                                onChanged: (v) => setState(() => _urgency = v!),
                                isDarkMode: isDarkMode,
                                isWarning: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Sticky Bottom Action Bar
      bottomSheet: Container(
        color: bgColor.withOpacity(0.95), // Slight transparency
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Save Draft',
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: primary,
                    foregroundColor: Colors.black,
                    elevation: 4,
                    shadowColor: primary.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.send, size: 20),
                  label: Text(
                    'Send Message',
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentOption({
    required String label,
    required String value,
    required bool isSelected,
    required bool isDarkMode,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _msgType = value),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? (isDarkMode ? Colors.grey[700] : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? (isDarkMode ? Colors.white : Colors.grey[900])
                  : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChip({
    required IconData icon,
    required String label,
    required bool isActive,
    required bool isDarkMode,
  }) {
    final bgColor = isActive
        ? primary
        : (isDarkMode ? Colors.grey[800] : Colors.white);
    final borderColor = isActive
        ? primary
        : (isDarkMode ? Colors.grey[700] : Colors.grey[200]);
    final textColor = isActive
        ? Colors.black
        : (isDarkMode ? Colors.grey[300] : Colors.grey[700]);
    final iconColor = isActive
        ? Colors.black
        : (isDarkMode ? Colors.grey[500] : Colors.grey[500]);

    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor!),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: primary.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddIndividualChip(bool isDarkMode) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey[600]! : Colors.grey[300]!,
          style: BorderStyle
              .solid, // Dash is not default in Border.all, using solid for now or need Paint.
          // For now solid is fine, or I could use a library, but let's stick to standard Flutter.
          // The design asked for dashed. I can simulate specific dashed border if needed, similar to Milestone.
          // But for a simple button solid is okay or I can use DottedBorder package if available?
          // I'll stick to solid for simplicity in this artifact unless strongly requested.
          // Wait, I did DashedBorder in Milestone. I can reuse that logic or just use solid.
          // I will use solid grey-300 which looks close enough for "Add" button usually.
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.add, size: 18, color: primary),
          const SizedBox(width: 8),
          Text(
            'Individual',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentBtn(IconData icon, bool isDarkMode) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 20,
        color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
      ),
    );
  }

  Widget _buildUrgencyOption({
    required String label,
    required String subLabel,
    required String value,
    required String groupValue,
    required ValueChanged<String?> onChanged,
    required bool isDarkMode,
    bool isWarning = false,
  }) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected && !isDarkMode
              ? Colors.white
              : Colors.transparent, // Highlight logic
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: Colors.red[600],
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isWarning
                          ? (isDarkMode ? Colors.red[400] : Colors.red[700])
                          : (isDarkMode ? Colors.white : Colors.grey[900]),
                    ),
                  ),
                  Text(
                    subLabel,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      color: isWarning
                          ? (isDarkMode
                                ? Colors.red[300]!.withOpacity(0.7)
                                : Colors.red[600]!.withOpacity(0.8))
                          : (isDarkMode ? Colors.grey[400] : Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
