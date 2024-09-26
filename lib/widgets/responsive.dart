import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  final double minWidth; // Add minimum width

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.minWidth = 400, // Default minimum width set to 400
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // Wrap with ConstrainedBox to enforce minimum width
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth, // Apply the minimum width constraint
      ),
      child: Builder(
        builder: (context) {
          if (size.width >= 1100) {
            return desktop;
          } else if (size.width >= 850 && tablet != null) {
            return tablet!;
          } else {
            return mobile;
          }
        },
      ),
    );
  }
}
