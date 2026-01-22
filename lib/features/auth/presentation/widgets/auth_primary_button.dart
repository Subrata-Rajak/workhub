import 'package:flutter/material.dart';
import '../../../../core/ui/app_text.dart';
import '../../../../src/src.dart';

class AuthPrimaryButton extends StatelessWidget {
  final String text;
  final String semanticLabel;
  final VoidCallback onPressed;
  final bool isLoading;

  const AuthPrimaryButton({
    super.key,
    required this.text,
    required this.semanticLabel,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: Tooltip(
        message: semanticLabel,
        waitDuration: const Duration(seconds: 1),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textInverse,
            disabledBackgroundColor: AppColors.primary.withAlpha(128), // ~0.5
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(AppRadius.mdRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          ),
          child: isLoading
              ? const SizedBox(
                  width: AppSpacing.lg, // 24
                  height: AppSpacing.lg, // 24
                  child: CircularProgressIndicator(
                    color: AppColors.textInverse,
                    strokeWidth: 2,
                  ),
                )
              : Semantics(
                  label: semanticLabel,
                  button: true,
                  excludeSemantics: true,
                  child: AppText.button(
                    text,
                    style: AppTextStyles.label.copyWith(
                      fontSize: 16,
                      color: AppColors.textInverse,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
      ),
    );
  }
}
