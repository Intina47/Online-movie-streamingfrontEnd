import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Responsive extends StatelessWidget {
  final Widget mobile;
  Widget? tablet;
  final Widget desktop;

  Responsive({
    Key? key,
    required this.mobile,
    required this.desktop,
    this.tablet,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 350;

  static bool istablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 350;

  static bool isdesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 350;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return desktop;
        } else if (constraints.maxWidth >= 800) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}
