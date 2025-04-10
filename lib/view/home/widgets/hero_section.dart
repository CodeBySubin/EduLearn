  import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

Widget heroSection() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1E3A8A).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
                right: -30,
                bottom: -30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.network(
                      'https://picsum.photos/id/433/300/300',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
              .animate()
              .fade(duration: 800.ms)
              .scale(
                begin: Offset(0.8, 0.8),
                end: Offset(1, 1),
                curve: Curves.easeOutBack,
              ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                      'Welcome Back, Alex!',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: -0.2, end: 0),
                SizedBox(height: 12),
                Text(
                      'Continue your learning journey and discover new subjects',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 600.ms)
                    .slideX(begin: -0.2, end: 0),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                            onPressed: () {
                              // Continue learning functionality
                            },
                            icon: Icon(Icons.play_circle_filled),
                            label: Text('Continue Learning'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Color(0xFF1E3A8A),
                              padding: EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 400.ms, duration: 600.ms)
                          .scale(delay: 400.ms, curve: Curves.easeOutBack),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.2,
                            ),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.all(12),
                            minimumSize: Size(0, 45),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Icon(Icons.search, color: Colors.white),
                        )
                        .animate()
                        .fadeIn(delay: 600.ms, duration: 600.ms)
                        .scale(delay: 600.ms, curve: Curves.easeOutBack),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
