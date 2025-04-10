import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lms_project/view/home/widgets/subjects_section.dart';
import 'package:lms_project/viewmodels/home_viewmodel.dart';
import 'package:lms_project/widget/error_widget.dart';
import 'package:lms_project/widget/loader_widget.dart';
import 'package:provider/provider.dart';

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  //   @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Provider.of<HomeViewModel>(context, listen: false).fetchHome();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return loader();
        }
        if (viewModel.errorMessage != null) {
          return buildErrorWidget(
            context: context,
            message: viewModel.errorMessage!,
            onRetry: () {
              Provider.of<HomeViewModel>(context, listen: false).fetchHome();
            },
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: viewModel.homelsit.length,
          itemBuilder: (context, index) {
            return subjectListItem(viewModel.homelsit[index], context)
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
        );
      },
    );
  }
}
