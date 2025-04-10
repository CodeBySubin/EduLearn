import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header with gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade700, Colors.blue.shade900],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    // Profile image
                    Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Center(
                              child: Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.blue.shade300,
                              ),
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                        .scaleXY(
                          begin: 0.85,
                          end: 1,
                          duration: 500.ms,
                          curve: Curves.easeOut,
                        ),

                    const SizedBox(height: 15),

                    // User name
                    Text(
                          'Alex Johnson',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 300.ms, duration: 600.ms)
                        .moveY(
                          begin: 10,
                          end: 0,
                          delay: 300.ms,
                          duration: 600.ms,
                          curve: Curves.easeOutQuad,
                        ),

                    // User email
                    Text(
                          'alex.johnson@example.com',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 500.ms)
                        .moveY(
                          begin: 10,
                          end: 0,
                          delay: 500.ms,
                          duration: 500.ms,
                          curve: Curves.easeOutQuad,
                        ),

                    const SizedBox(height: 15),

                    // Stats row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStatItem(
                          '12',
                          'Courses',
                        ).animate().fadeIn(delay: 700.ms, duration: 400.ms),
                        _buildStatDivider().animate().fadeIn(
                          delay: 800.ms,
                          duration: 400.ms,
                        ),
                        _buildStatItem(
                          '85%',
                          'Progress',
                        ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
                        _buildStatDivider().animate().fadeIn(
                          delay: 1000.ms,
                          duration: 400.ms,
                        ),
                        _buildStatItem(
                          '4.8',
                          'Rating',
                        ).animate().fadeIn(delay: 1100.ms, duration: 400.ms),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Profile sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                        'Account Settings',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade900,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 400.ms)
                      .moveX(
                        begin: -20,
                        end: 0,
                        delay: 600.ms,
                        duration: 400.ms,
                      ),

                  const SizedBox(height: 15),

                  // Settings options
                  _buildAnimatedMenuItem(
                    Icons.person_outline,
                    'Personal Information',
                    () {},
                    800.ms,
                  ),
                  _buildAnimatedMenuItem(
                    Icons.notifications_outlined,
                    'Notifications',
                    () {},
                    900.ms,
                  ),
                  _buildAnimatedMenuItem(
                    Icons.security_outlined,
                    'Security',
                    () {},
                    1000.ms,
                  ),
                  _buildAnimatedMenuItem(
                    Icons.language_outlined,
                    'Language',
                    () {},
                    1100.ms,
                  ),

                  const SizedBox(height: 25),

                  Text(
                        'Learning',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade900,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 1200.ms, duration: 400.ms)
                      .moveX(
                        begin: -20,
                        end: 0,
                        delay: 1200.ms,
                        duration: 400.ms,
                      ),

                  const SizedBox(height: 15),

                  // Learning options
                  _buildAnimatedMenuItem(
                    Icons.school_outlined,
                    'My Courses',
                    () {},
                    1300.ms,
                  ),
                  _buildAnimatedMenuItem(
                    Icons.assignment_outlined,
                    'Certificates',
                    () {},
                    1400.ms,
                  ),
                  _buildAnimatedMenuItem(
                    Icons.star_outline,
                    'Achievements',
                    () {},
                    1500.ms,
                  ),

                  const SizedBox(height: 25),

                  // Logout button
                  Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextButton.icon(
                          icon: Icon(Icons.logout, color: Colors.red.shade600),
                          label: Text(
                            'Log Out',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade600,
                            ),
                          ),
                          onPressed: () {
                            // Logout logic
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.red.shade200),
                            ),
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 1600.ms, duration: 500.ms)
                      .shimmer(
                        delay: 1600.ms,
                        duration: 1800.ms,
                        blendMode: BlendMode.srcIn,
                      ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.white.withValues(alpha: 0.3),
    );
  }

  Widget _buildAnimatedMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap,
    Duration delay,
  ) {
    return _buildProfileMenuItem(icon, title, onTap)
        .animate()
        .fadeIn(delay: delay, duration: 400.ms)
        .slideX(
          begin: 0.2,
          end: 0,
          delay: delay,
          duration: 400.ms,
          curve: Curves.easeOutQuad,
        );
  }

  Widget _buildProfileMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue.shade700),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
        onTap: () {
          // Add tap animation with flutter_animate
          final BuildContext currentContext = context;

          // Create a ripple effect on tap
          ScaffoldMessenger.of(currentContext).clearSnackBars();
          ScaffoldMessenger.of(currentContext).showSnackBar(
            SnackBar(
              content: Text('Opening $title'),
              duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
            ),
          );

          // Execute the actual onTap function
          onTap();
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

// Extension to make the menu item tappable with effect
extension TapEffectExtension on Widget {
  Widget addTapEffect({
    required VoidCallback onTap,
    Duration duration = const Duration(milliseconds: 50),
  }) {
    return GestureDetector(
          onTap: () {
            onTap();
          },
          child: this,
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scaleXY(begin: 1, end: 0.95, duration: duration);
  }
}
