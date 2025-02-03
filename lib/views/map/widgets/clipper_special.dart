import 'package:flutter/material.dart';

class CustomRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 8.0;

    Path path = Path();

    // Start at bottom-left (sharp corner)
    path.moveTo(0, size.height);

    // Move to top-left with rounded corner
    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);

    // Move to top-right with rounded corner
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // Move to bottom-right with rounded corner
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - radius, size.height);

    // Move back to bottom-left (sharp corner)
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
