import 'package:flutter/material.dart';
import 'package:lms_project/core/utils/colors.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final List<Color> gradientColors;
  final bool backbutton;
  final Widget? leading;

  const GradientAppBar({
    super.key,
    required this.title,
    this.height = kToolbarHeight,
    this.gradientColors = const [
      AppColors.gradient_bottom,
      AppColors.gradient_top,
    ],
    this.backbutton = false,
    this.leading,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.colorprimary,
      title: Text(title),
      leading:
          backbutton
              ? InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios, color: AppColors.white),
              )
              : leading,

      elevation: 0,
    );
  }
}
