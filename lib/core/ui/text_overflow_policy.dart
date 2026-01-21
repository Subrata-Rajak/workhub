/// Authoritative text overflow rules for the application.
class TextOverflowPolicy {
  /// Page titles should typically be concise but can wrap to a second line if needed.
  static const int titleMaxLines = 2;

  /// Section headers should be strictly one line.
  static const int headerMaxLines = 1;

  /// Body text is allowed to wrap comfortably but should not run infinitely.
  static const int bodyMaxLines = 4;

  /// Buttons must NEVER wrap. They should truncate if space is insufficient.
  static const int buttonMaxLines = 1;

  /// Links/labels should stay on one line.
  static const int linkMaxLines = 1;
}
