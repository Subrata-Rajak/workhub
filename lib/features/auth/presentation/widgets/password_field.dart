import 'package:flutter/material.dart';
import '../../../../src/src.dart';

class PasswordField extends StatelessWidget {
  final String label;
  final String hint;
  final ValueChanged<String>? onChanged;
  final bool isObscured;
  final VoidCallback? onVisibilityToggle;
  final String? errorText;

  const PasswordField({
    super.key,
    this.label = 'Password wgwg',
    this.hint = '••••••••',
    this.onChanged,
    this.isObscured = true,
    this.onVisibilityToggle,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary, // Was grey[800]
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        TextFormField(
          onChanged: onChanged,
          obscureText: isObscured,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.textMuted),
            errorText: errorText,
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
            suffixIcon: IconButton(
              icon: Icon(
                isObscured
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.textMuted,
              ),
              onPressed: onVisibilityToggle,
            ),
          ),
        ),
      ],
    );
  }
}
