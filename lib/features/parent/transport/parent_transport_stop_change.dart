import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class ParentTransportStopChangePage extends StatefulWidget {
  const ParentTransportStopChangePage({super.key});

  @override
  State<ParentTransportStopChangePage> createState() =>
      _ParentTransportStopChangePageState();
}

class _ParentTransportStopChangePageState
    extends State<ParentTransportStopChangePage> {
  String _changeType = 'Temporary'; // or Permanent
  String _selectedStop = 'Grandma\'s House (Zone B)';
  DateTime _startDate = DateTime.now().add(const Duration(days: 1));
  DateTime? _endDate = DateTime.now().add(const Duration(days: 7)); // For temp

  final List<String> _availableStops = [
    'Home (Current)',
    'Grandma\'s House (Zone B)',
    'Daycare Center (Zone A)',
    'Office (Zone C)',
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final surfaceColor = isDarkMode
        ? AppColors.surfaceDark
        : AppColors.surfaceLight;
    final textColor = isDarkMode
        ? AppColors.textMainDark
        : AppColors.textMainLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Change Transport Stop',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Request Type',
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildRadioChip('Temporary', isDarkMode),
                const SizedBox(width: 16),
                _buildRadioChip('Permanent', isDarkMode),
              ],
            ),
            const SizedBox(height: 32),

            _buildSectionLabel('Select New Stop', textColor),
            DropdownButtonFormField<String>(
              initialValue: _selectedStop,
              dropdownColor: surfaceColor,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                filled: true,
                fillColor: surfaceColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
              items: _availableStops
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedStop = val!),
            ),

            const SizedBox(height: 24),
            _buildSectionLabel('Effective From', textColor),
            _buildDatePicker(
              context,
              _startDate,
              (d) => setState(() => _startDate = d),
              surfaceColor,
              textColor,
            ),

            if (_changeType == 'Temporary') ...[
              const SizedBox(height: 24),
              _buildSectionLabel('Until (Inclusive)', textColor),
              _buildDatePicker(
                context,
                _endDate!,
                (d) => setState(() => _endDate = d),
                surfaceColor,
                textColor,
              ),
            ],

            const SizedBox(height: 24),
            TextField(
              style: TextStyle(color: textColor),
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Reason / Special Instructions...',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: surfaceColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 40),
            PrimaryButton(
              label: 'Submit Request',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Stop Change Request Submitted!'),
                    backgroundColor: AppColors.success,
                  ),
                );
                Navigator.pop(context);
              },
              width: double.infinity,
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Requests must be made 24 hours in advance.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioChip(String value, bool isDarkMode) {
    bool isSelected = _changeType == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _changeType = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : Colors.grey.withValues(alpha: 0.5),
            ),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: GoogleFonts.lexend(
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildDatePicker(
    BuildContext context,
    DateTime date,
    Function(DateTime) onSelect,
    Color surfaceColor,
    Color textColor,
  ) {
    return InkWell(
      onTap: () async {
        final d = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (d != null) onSelect(d);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${date.year}-${date.month}-${date.day}',
              style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
            ),
            Icon(Icons.calendar_today, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }
}
