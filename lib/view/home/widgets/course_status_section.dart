  import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

Widget curseStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
                  'In Progress',
                  '3',
                  Icons.watch_later_outlined,
                  Color(0xFFFEF3C7),
                  Color(0xFFD97706),
                )
                .animate()
                .fadeIn(duration: 400.ms)
                .scale(delay: 100.ms, curve: Curves.easeOutBack),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
                  'Completed',
                  '12',
                  Icons.check_circle_outline,
                  Color(0xFFDCFCE7),
                  Color(0xFF059669),
                )
                .animate()
                .fadeIn(duration: 400.ms)
                .scale(delay: 300.ms, curve: Curves.easeOutBack),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
                  'Certificates',
                  '5',
                  Icons.card_membership,
                  Color(0xFFDDEAFE),
                  Color(0xFF1E40AF),
                )
                .animate()
                .fadeIn(duration: 400.ms)
                .scale(delay: 500.ms, curve: Curves.easeOutBack),
          ),
        ],
      ),
    );
  }


  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                duration: 2000.ms,
                begin: Offset(1, 1),
                end: Offset(1.1, 1.1),
              ),
          SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
          SizedBox(height: 4),
          Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(delay: 200.ms, duration: 400.ms)
              .slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }