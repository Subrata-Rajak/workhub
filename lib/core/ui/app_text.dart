import 'package:flutter/material.dart';
import 'text_overflow_policy.dart';

/// A wrapper around [Text] that enforces strictly defined overflow policies.
/// Use named constructors to ensure semantic correctness.
class AppText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int maxLines;
  final TextOverflow overflow;

  /// Use for primary page titles. Max 2 lines.
  const AppText.title(this.data, {super.key, this.style, this.textAlign})
    : maxLines = TextOverflowPolicy.titleMaxLines,
      overflow = TextOverflow.ellipsis;

  /// Use for section headers. Max 1 line.
  const AppText.header(this.data, {super.key, this.style, this.textAlign})
    : maxLines = TextOverflowPolicy.headerMaxLines,
      overflow = TextOverflow.ellipsis;

  /// Use for general content. Max 4 lines (wraps).
  const AppText.body(this.data, {super.key, this.style, this.textAlign})
    : maxLines = TextOverflowPolicy.bodyMaxLines,
      overflow = TextOverflow.ellipsis;

  /// Use for buttons. STRICTLY 1 line.
  const AppText.button(this.data, {super.key, this.style, this.textAlign})
    : maxLines = TextOverflowPolicy.buttonMaxLines,
      overflow = TextOverflow.ellipsis;

  /// Use for links or small labels. STRICTLY 1 line.
  const AppText.link(this.data, {super.key, this.style, this.textAlign})
    : maxLines = TextOverflowPolicy.linkMaxLines,
      overflow = TextOverflow.ellipsis;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
