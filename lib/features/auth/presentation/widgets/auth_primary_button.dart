import 'package:flutter/material.dart';
import '../../../../core/ui/app_text.dart';

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
      height: 48,
      width: double.infinity,
      child: Tooltip(
        message: semanticLabel,
        waitDuration: const Duration(seconds: 1),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E6B66),
            foregroundColor: Colors.white,
            disabledBackgroundColor: const Color(
              0xFF2E6B66,
            ).withAlpha(128), // ~0.5
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Semantics(
                  label: semanticLabel,
                  button: true,
                  excludeSemantics: true,
                  child: AppText.button(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
      ),
    );
  }
}
