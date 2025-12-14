import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class ConsentSection extends StatelessWidget {
  final String title;
  final String content;

  const ConsentSection({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.heading3.copyWith(
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: AppTypography.bodyRegular.copyWith(
              color: AppColors.gray600,
              height: 1.5, // improved readability
            ),
          ),
        ],
      ),
    );
  }
}
