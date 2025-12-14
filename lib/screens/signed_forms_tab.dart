import 'package:flutter/material.dart';
import '../models/signed_form.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/signed_form_card.dart';

class SignedFormsTab extends StatelessWidget {
  const SignedFormsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final List<SignedForm> forms = [
      SignedForm(
        id: '1',
        patientName: 'Mrs. Sanam Naik',
        gender: 'Female',
        age: 32,
        procedureName: 'Root Canal Treatment',
        timestamp: now.subtract(const Duration(seconds: 30)),
      ),
      SignedForm(
        id: '2',
        patientName: 'Ms. Neelam Naik',
        gender: 'Female',
        age: 32,
        procedureName: 'Scaling and Root Planing (Deep Cleaning)',
        timestamp: today.add(const Duration(hours: 11)),
      ),
      SignedForm(
        id: '3',
        patientName: 'Mr. Babu Kamat',
        gender: 'Male',
        age: 32,
        procedureName: 'Root Canal Treatment',
        timestamp: today.add(const Duration(hours: 10, minutes: 22)),
      ),
      SignedForm(
        id: '4',
        patientName: 'Mr. Pereira',
        gender: 'Male',
        age: 32,
        procedureName: 'Orthodontic Treatment',
        timestamp: today.add(const Duration(hours: 9, minutes: 30)),
      ),
      SignedForm(
        id: '5',
        patientName: 'Mr. Peter Fernandes',
        gender: 'Male',
        age: 32,
        procedureName: 'Scaling and Root Planing (Deep Cleaning)',
        timestamp: yesterday.add(const Duration(hours: 14, minutes: 6)),
      ),
      SignedForm(
        id: '6',
        patientName: 'Ms. Neelam Prabhu',
        gender: 'Female',
        age: 32,
        procedureName: 'Root Canal Treatment',
        timestamp: yesterday.add(const Duration(hours: 12, minutes: 32)),
      ),
      SignedForm(
        id: '7',
        patientName: 'Mr. Prashant Prabhu',
        gender: 'Male',
        age: 32,
        procedureName: 'Orthodontic Treatment',
        timestamp: yesterday.add(const Duration(hours: 11, minutes: 12)),
      ),
      SignedForm(
        id: '8',
        patientName: 'Mr. Kamat',
        gender: 'Male',
        age: 32,
        procedureName: 'Root Canal Treatment',
        timestamp: yesterday.add(const Duration(hours: 10, minutes: 2)),
      ),
    ];

    // Grouping Logic
    final Map<String, List<SignedForm>> groupedForms = {};
    
    for (var form in forms) {
      final formDate = DateTime(form.timestamp.year, form.timestamp.month, form.timestamp.day);
      String key;
      if (formDate == today) {
        key = 'Today, 20 Oct 2025'; // Hardcoded date for visual match, ideally dynamic
      } else if (formDate == yesterday) {
        key = 'Yesterday, 20 Oct 2025'; // Hardcoded date for visual match
      } else {
        key = '${formDate.day} ${_getMonthName(formDate.month)} ${formDate.year}';
      }
      
      if (!groupedForms.containsKey(key)) {
        groupedForms[key] = [];
      }
      groupedForms[key]!.add(form);
    }

    return Column(
      children: [
        // Filters and Search
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              _buildFilterChip('Date'),
              const SizedBox(width: 12),
              _buildFilterChip('Type'),
              const Spacer(),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.gray500),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: AppColors.gray200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: AppColors.gray200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: AppColors.blue500),
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            itemCount: groupedForms.length,
            itemBuilder: (context, index) {
              final key = groupedForms.keys.elementAt(index);
              final formsForKey = groupedForms[key]!;
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
                    child: Text(
                      key,
                      style: AppTypography.bodyRegularSemibold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  ...formsForKey.map((form) => SignedFormCard(form: form)),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(color: AppColors.black),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.black),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
