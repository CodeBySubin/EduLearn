import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:lms_project/core/utils/string_constants.dart';
import 'package:lms_project/model/home_model.dart';
import 'package:lms_project/view/module/modules.dart';

Widget featuredSubjectsSection(List<Homemodel> subjects) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              StringConstants.featured_subject,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2, end: 0),
            TextButton(
              onPressed: () {},
              child: Text(
                StringConstants.seeAll,
                style: GoogleFonts.poppins(
                  color: Color(0xFF1E3A8A),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2, end: 0),
          ],
        ),
      ),
      SizedBox(
        height: 200,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: subjects.length > 3 ? 3 : subjects.length,
          itemBuilder: (context, index) {
            return _buildFeaturedSubjectCard(subjects[index], context)
                .animate()
                .fadeIn(delay: 100.ms * index, duration: 500.ms)
                .slideX(begin: 0.2, end: 0)
                .scale(delay: 200.ms * index, curve: Curves.easeOutBack);
          },
        ),
      ),
    ],
  );
}


Widget _buildFeaturedSubjectCard(Homemodel subjects, BuildContext context) {
  return Container(
    width: 280,
    margin: EdgeInsets.only(right: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ModulesPage(module: subjects),
          ),
        );
      },
      child: Stack(
        children: [
          Hero(
            tag: 'subject_${subjects.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: subjects.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                                color: Color(0xFF1E3A8A),
                                strokeWidth: 2,
                              )
                              .animate(
                                onPlay: (controller) => controller.repeat(),
                              )
                              .rotate(duration: 1500.ms),
                        ),
                      ),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                      ).animate().shake(hz: 4, curve: Curves.easeInOut),
                    ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 16,
            right: 16,
            child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    StringConstants.featured,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                )
                .animate()
                .fadeIn(delay: 300.ms, duration: 400.ms)
                .scale(curve: Curves.elasticOut),
          ),
        ],
      ),
    ),
  );
}
