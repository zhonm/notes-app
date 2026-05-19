import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// Using PlatformDispatcher for better future compatibility
// TODO: Migrate to View.of(context) pattern when refactoring to context-aware design
// ignore: deprecated_member_use
final screenWidth = (ui.window.physicalSize.width / ui.window.devicePixelRatio);
// ignore: deprecated_member_use
final screenHeight = (ui.window.physicalSize.height / ui.window.devicePixelRatio);
// ignore: deprecated_member_use
final safePaddingTop = WidgetsBinding.instance.window.padding.top;
// ignore: deprecated_member_use
final safePaddingBottom = WidgetsBinding.instance.window.padding.bottom;

TextStyle headingStyle = const TextStyle(
  fontSize: 34,
  fontWeight: FontWeight.w700,
  color: Color(0xFF111827),
  fontFamily: "Montserrat",
);

TextStyle subheadingStyle = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Color(0xFF4B5563),
  fontFamily: "Montserrat",
);

TextStyle noteTitleStyle = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: Color(0xFF111827),
  fontFamily: "Montserrat",
);

TextStyle notePreviewStyle = const TextStyle(
  fontSize: 14,
  color: Color(0xFF475569),
  height: 1.5,
  fontFamily: "Montserrat",
);

TextStyle noteBodyStyle = const TextStyle(
  fontSize: 16,
  color: Color(0xFF1F2937),
  height: 1.6,
  fontFamily: "Montserrat",
);
