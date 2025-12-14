import 'package:flutter/material.dart';
import '../models/signed_form.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class SignedFormCard extends StatelessWidget {
  final SignedForm form;

  const SignedFormCard({
    super.key,
    required this.form,
  });

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} SECS AGO';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} MINS AGO';
    } else {
      // Simple time formatting HH:MM AM/PM
      final hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
      final minute = time.minute.toString().padLeft(2, '0');
      final period = time.hour >= 12 ? 'PM' : 'AM';
      return '$hour:$minute $period';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  form.patientName,
                  style: AppTypography.bodyRegularSemibold.copyWith(
                    fontSize: 18, // Slightly larger for name
                  ),
                ),
              ),
              Text(
                _formatTime(form.timestamp),
                style: AppTypography.bodyMicro.copyWith(
                  color: AppColors.gray500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${form.gender.toUpperCase()} • ${form.age} YRS',
            style: AppTypography.bodyMicro.copyWith(
              color: AppColors.gray600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            form.procedureName,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.gray600,
            ),
          ),
        ],
      ),
    );
  }
}
