/// Semantically meaningful desktop window sizes.
enum DesktopSize {
  /// < 900px width.
  /// Typically used for split-screen or narrow windows.
  /// UI should likely collapse side panels and stack content vertically.
  compact,

  /// 900px - 1200px width.
  /// Standard laptop or small desktop window.
  /// UI can show side panels but content might be tighter.
  standard,

  /// 1200px - 1600px width.
  /// Typical desktop monitor.
  /// Spacious UI.
  wide,

  /// > 1600px width.
  /// Large monitors.
  /// UI should be constrained to a max width to avoid excessive stretching.
  ultraWide,
}

/// Breakpoint constants for desktop sizes.
class DesktopBreakpoints {
  static const double compactThreshold = 900.0;
  static const double standardThreshold = 1200.0;
  static const double wideThreshold = 1600.0;
}
