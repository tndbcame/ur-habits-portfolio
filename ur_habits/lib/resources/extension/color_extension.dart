import 'dart:ui';

extension ColorExtension on Color {
  Color applyOpacity(double opacity) {
    final alpha = (opacity * 255).round().clamp(0, 255);
    return withAlpha(alpha);
  }
}
