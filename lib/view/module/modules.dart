import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lms_project/core/utils/helper.dart';
import 'package:lms_project/model/home_model.dart';
import 'package:lms_project/view/module/module_item.dart';
import 'package:lms_project/view/video/videolisting.dart';
import 'package:lms_project/viewmodels/modules_viewmodel.dart';
import 'package:lms_project/widget/error_widget.dart';
import 'package:lms_project/widget/infochip.dart';
import 'package:lms_project/widget/loader_widget.dart';
import 'package:provider/provider.dart';

class ModulesPage extends StatefulWidget {
  final Homemodel module;

  const ModulesPage({super.key, required this.module});

  @override
  State<ModulesPage> createState() => _ModulesPageState();
}

class _ModulesPageState extends State<ModulesPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ModulesViewmodel>(
        context,
        listen: false,
      ).fetchModules(widget.module.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final iconWithColor = getIconWithColor(widget.module.title);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.module.title,
        ).animate().fadeIn(duration: const Duration(milliseconds: 500)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ).animate().scale(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        ),
      ),
      body: Consumer<ModulesViewmodel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return loader();
          }
          if (viewModel.errorMessage != null) {
            return buildErrorWidget(
              context: context,
              message:viewModel.errorMessage!,
              onRetry: () {
                viewModel.fetchModules(widget.module.id);
              },
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subject header
                  Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: iconWithColor.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: iconWithColor.color.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                      iconWithColor.icon,
                                      size: 32,
                                      color: iconWithColor.color,
                                    )
                                    .animate()
                                    .scale(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.elasticOut,
                                    )
                                    .then()
                                    .shake(hz: 4, rotation: 0.02),
                                const SizedBox(width: 12),
                                Text(
                                  widget.module.title,
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).animate().fadeIn(
                                  delay: const Duration(milliseconds: 200),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                                  widget.module.description,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                )
                                .animate()
                                .fadeIn(
                                  delay: const Duration(milliseconds: 300),
                                )
                                .slideX(begin: 0.2, end: 0),
                            const SizedBox(height: 16),
                            infoChip(
                                  Icons.book,
                                  '${viewModel.modulelist.length} modules',
                                )
                                .animate()
                                .fadeIn(
                                  delay: const Duration(milliseconds: 400),
                                )
                                .slideX(begin: 0.2, end: 0),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: const Duration(milliseconds: 600))
                      .slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 24),
                  // Modules list header
                  Text(
                        'Available Modules',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 300))
                      .slideX(begin: 0.2, end: 0),
                  const SizedBox(height: 16),
                  // Modules list
                  ModuleItem(modulelist: viewModel.modulelist),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
