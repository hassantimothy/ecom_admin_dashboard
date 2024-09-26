// lib/utility/responsive.dart
import 'package:flutter/material.dart';

// This widget manages layout changes for mobile, tablet, and desktop views
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  // Determine if the screen is mobile based on width
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  // Determine if the screen is tablet based on width
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  // Determine if the screen is desktop based on width
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // Return desktop view if screen width is >= 1100
    if (size.width >= 1100) {
      return desktop;
    }
    // Return tablet view if screen width is between 850 and 1100
    else if (size.width >= 850 && tablet != null) {
      return tablet!;
    }
    // Return mobile view if screen width is less than 850
    else {
      return mobile;
    }
  }
}
