import 'package:flutter/material.dart';

class AppDimens {
  static const double _tabletBreakpoint = 600;
  static const double _desktopBreakpoint = 1200;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < _tabletBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= _tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= _desktopBreakpoint;

  // Padding horizontal du contenu principal
  static double horizontalPadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= _desktopBreakpoint) return 24;
    if (w >= _tabletBreakpoint) return 20;
    return 16;
  }

  // Largeur max du feed (centré sur tablette)
  static double contentMaxWidth(BuildContext context) =>
      isTablet(context) ? 600 : double.infinity;

  // Rayon des avatars du feed
  static double avatarRadius(BuildContext context) =>
      isTablet(context) ? 28 : 24;
}
