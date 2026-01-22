import 'package:flutter/material.dart';
import '../../../../src/src.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary, // Was grey[800]
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: AppColors.textMuted,
            ), // Was grey[400]
            errorText: errorText, // Display error directly from BLoC if needed
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(AppRadius.mdRadius),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(AppRadius.mdRadius),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(AppRadius.mdRadius),
              borderSide: BorderSide(color: AppColors.borderFocus),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
          ),
        ),
      ],
    );
  }
}
