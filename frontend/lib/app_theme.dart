import 'dart:ui';
import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF0B0F14);
  static const Color surface = Color(0xFF151A22);
  static const Color card = Color(0xFF1B212C);
  static const Color accent = Color(0xFF5CE1E6);
  static const Color accentBlue = Color(0xFF4A80F0);
  static const Color textPrimary = Color(0xFFF5F7FA);
  static const Color textSecondary = Color(0xFF9AA4B2);
  static const Color border = Color(0xFF2A3441);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: ColorScheme.dark(
        primary: accent,
        secondary: accentBlue,
        surface: surface,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: Color(0xFFF5F7FA),
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(
          color: Color(0xFFE2E8F0),
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          color: Color(0xFFF8FAFC),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card.withValues(alpha: 0.9),
        hintStyle: const TextStyle(
          color: Color(0xFFB8C2D1),
          fontSize: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: border.withValues(alpha: 0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: accent, width: 1.4),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: const Color(0xFF0B0F14),
          disabledBackgroundColor: const Color(0xFF1E293B),
          disabledForegroundColor: const Color(0xFF94A3B8),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}

class GradientBackdrop extends StatelessWidget {
  const GradientBackdrop({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0B0F14),
            Color(0xFF131A24),
            Color(0xFF1A2330),
            Color(0xFF101820),
          ],
        ),
      ),
      child: child,
    );
  }
}

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: AppTheme.card.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 30,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
