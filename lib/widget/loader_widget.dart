import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

Widget loader() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color(0xFF1E3A8A))
            .animate(onPlay: (controller) => controller.repeat())
            .scale(duration: 700.ms, begin: Offset(0.8, 0.8), end: Offset(1.2, 1.2))
            .then(delay: 700.ms)
            .scale(duration: 700.ms, begin: Offset(1.2, 1.2), end: Offset(0.8, 0.8)),
          SizedBox(height: 16),
          Text(
            'Loading content...',
            style: GoogleFonts.poppins(color: Color(0xFF1E3A8A), fontSize: 16),
          ).animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  
}
