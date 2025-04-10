import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lms_project/core/utils/helper.dart';
import 'package:lms_project/core/utils/string_constants.dart';
import 'package:lms_project/model/home_model.dart';
import 'package:lms_project/view/module/modules.dart';

class AllSubjectsSection extends StatefulWidget {
  final List<Homemodel> homemodel;
  const AllSubjectsSection({super.key, required this.homemodel});

  @override
  State<AllSubjectsSection> createState() => _AllSubjectsSectionState();
}

class _AllSubjectsSectionState extends State<AllSubjectsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                    StringConstants.allSubjects,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideX(
                    begin: -0.2,
                    end: 0,
                    duration: 600.ms,
                    curve: Curves.easeOutQuad,
                  ),

              TextButton(
                    onPressed: () {},
                    child: Text(
                      StringConstants.viewAll,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF1E3A8A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideX(
                    begin: 0.2,
                    end: 0,
                    duration: 600.ms,
                    curve: Curves.easeOutQuad,
                  ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: widget.homemodel.length,
          itemBuilder: (context, index) {
            // Create cascading animations with increasing delays for each item
            return subjectListItem(widget.homemodel[index],context)
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 300 + (index * 100)),
                  duration: 500.ms,
                  curve: Curves.easeOut,
                )
                .slideY(
                  begin: 0.2,
                  end: 0,
                  delay: Duration(milliseconds: 300 + (index * 100)),
                  duration: 500.ms,
                  curve: Curves.easeOutQuad,
                );
          },
        ),
      ],
    );
  }
}
  Widget subjectListItem(Homemodel subject,BuildContext context) {
    final iconWithColor = getIconWithColor(subject.title);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ModulesPage(module: subject)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: iconWithColor.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      iconWithColor.icon,
                      color: iconWithColor.color,
                      size: 24,
                    ),
                  )
                  .animate(onPlay: (controller) => controller.loop(count: 1))
                  .scaleXY(
                    begin: 0.8,
                    end: 1,
                    duration: 300.ms,
                    curve: Curves.elasticOut,
                  ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subject.description,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Color(0xFF1E3A8A),
                    ),
                  )
                  .animate(autoPlay: false)
                  .shake(hz: 3, curve: Curves.easeInOut)
                  .animate(target: _hoverArrowTarget)
                  .shimmer(
                    duration: 1000.ms,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  final _hoverArrowTarget = 0.0;

