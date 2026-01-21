import 'package:flutter/widgets.dart';
import 'desktop_breakpoints.dart';

class DesktopLayoutHelper {
  /// Returns the [DesktopSize] based on the provided width constraint or media query context.
  static DesktopSize getSize(double width) {
    if (width < DesktopBreakpoints.compactThreshold) {
      return DesktopSize.compact;
    } else if (width < DesktopBreakpoints.standardThreshold) {
      return DesktopSize.standard;
    } else if (width < DesktopBreakpoints.wideThreshold) {
      return DesktopSize.wide;
    } else {
      return DesktopSize.ultraWide;
    }
  }

  /// Returns the width based on the context's MediaQuery.
  /// Use this sparingly; prefer LayoutBuilder constraints for local responsiveness.
  static DesktopSize getSizeFromContext(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return getSize(width);
  }

  /// Suggested max content width based on size.
  static double getMaxContentWidth(DesktopSize size) {
    switch (size) {
      case DesktopSize.compact:
        return 600.0;
      case DesktopSize.standard:
        return 900.0;
      case DesktopSize.wide:
        return 1100.0;
      case DesktopSize.ultraWide:
        return 1200.0;
    }
  }

  /// Whether secondary panels (like the right-side illustration) should be visible.
  static bool shouldShowSidePanel(DesktopSize size) {
    return size != DesktopSize.compact;
  }

  /// Suggested horizontal padding for the main content area.
  static double getHorizontalPadding(DesktopSize size) {
    switch (size) {
      case DesktopSize.compact:
        return 32.0;
      case DesktopSize.standard:
        return 48.0;
      case DesktopSize.wide:
      case DesktopSize.ultraWide:
        return 64.0;
    }
  }
}
