import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

Widget errorWidget(String text) {
  return Center(
    child: Text(text, style: const TextStyle(color: Colors.red, fontSize: 16)),
  );
}

Widget buildErrorWidget({
  required BuildContext context,
  required String message,
  required VoidCallback onRetry,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 60, color: Colors.red[400])
            .animate()
            .scale(duration: 400.ms, curve: Curves.easeOutBack)
            .shake(hz: 4, curve: Curves.easeInOut),

        const SizedBox(height: 16),

        Text(
          'Oops! Something went wrong',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 400.ms)
            .slideY(begin: 0.2, end: 0),

        const SizedBox(height: 8),

        Text(
          message,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        )
            .animate()
            .fadeIn(delay: 400.ms, duration: 400.ms)
            .slideY(begin: 0.2, end: 0),

        const SizedBox(height: 24),

        ElevatedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text('Try Again'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 600.ms, duration: 400.ms)
            .scale(
              delay: 600.ms,
              duration: 400.ms,
              begin: const Offset(0.8, 0.8),
              end: const Offset(1, 1),
            ),
      ],
    ),
  );
}