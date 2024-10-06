import 'package:flutter/material.dart';

BoxShadow cardShadow() {
  return BoxShadow(
    color: const Color(0xFF404040).withOpacity(0.15),
    blurRadius: 10,
    spreadRadius: 1,
    offset: const Offset(2, 4),
  );
}
