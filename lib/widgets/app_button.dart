import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

enum AppButtonType { primary, outline }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.icon,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    if (type == AppButtonType.outline) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          side: const BorderSide(color: AppColors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _buildContent(AppColors.black),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blue500,
        disabledBackgroundColor: AppColors.gray300,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.gray300;
          }
          return AppColors.blue500;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.gray600;
          }
          return Colors.white;
        }),
      ),
      child: _buildContent(isDisabled ? AppColors.gray600 : Colors.white),
    );
  }

  Widget _buildContent(Color textColor) {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: AppTypography.bodySmallSemibold.copyWith(color: textColor),
          ),
          const SizedBox(width: 8),
          Icon(icon, size: 16, color: textColor),
        ],
      );
    }
    return Text(
      text,
      style: AppTypography.bodySmallSemibold.copyWith(color: textColor),
    );
  }
}
