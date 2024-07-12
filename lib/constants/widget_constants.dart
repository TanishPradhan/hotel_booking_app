import 'package:flutter/material.dart';
import 'colors.dart';


CircleAvatar imageWidget(double size) {
  return CircleAvatar(
    radius: size,
    backgroundColor: primaryColor.withOpacity(0.2),
    child: Icon(
      Icons.person,
      size: size + 10,
      color: primaryColor,
    ),
  );
}