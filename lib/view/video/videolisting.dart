import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lms_project/core/utils/helper.dart';
import 'package:lms_project/model/module_model.dart';
import 'package:lms_project/model/video_model.dart';
import 'package:lms_project/view/video/videoplayer.dart';
import 'package:lms_project/viewmodels/video_viewmodel.dart';
import 'package:lms_project/widget/error_widget.dart';
import 'package:lms_project/widget/loader_widget.dart';
import 'package:provider/provider.dart';

class VideoListPage extends StatefulWidget {
  final ModuleModel module;

  const VideoListPage({super.key, required this.module});

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VideoViewmodel>(
        context,
        listen: false,
      ).fetchvideos(widget.module.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Consumer<VideoViewmodel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return loader();
          }
          if (viewModel.errorMessage != null) {
            return buildErrorWidget(
              context: context,
              message:viewModel.errorMessage!,
              onRetry: () {
                viewModel.fetchvideos(widget.module.id);
              },
            );
          }
          return Column(
            children: [
              Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: Colors.blue.shade50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                              widget.module.title,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                            .animate()
                            .fadeIn(duration: const Duration(milliseconds: 400))
                            .slideX(begin: 0.2, end: 0),
                        const SizedBox(height: 8),
                        Text(
                              widget.module.description,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            )
                            .animate()
                            .fadeIn(
                              delay: const Duration(milliseconds: 200),
                              duration: const Duration(milliseconds: 400),
                            )
                            .slideX(begin: 0.2, end: 0),
                        const SizedBox(height: 12),
                        Row(
                              children: [
                                Icon(
                                  Icons.video_library,
                                  size: 16,
                                  color: Colors.blue[700],
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${viewModel.videolist.length} videos',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            )
                            .animate()
                            .fadeIn(
                              delay: const Duration(milliseconds: 400),
                              duration: const Duration(milliseconds: 400),
                            )
                            .slideX(begin: 0.2, end: 0),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 500))
                  .slideY(begin: -0.1, end: 0),

              // Video list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: viewModel.videolist.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => VideoPlayerPage(
                                      video: viewModel.videolist[index],
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child: Image.network(
                                        getVideoThumbnail(
                                          viewModel.videolist[index].videoUrl,
                                        ),
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Container(
                                            height: 180,
                                            color: Colors.grey[200],
                                            child: const Center(
                                              child: Icon(
                                                Icons.image_not_supported,
                                                color: Colors.grey,
                                                size: 40,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withValues(
                                              alpha: 0.8,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 36,
                                          ),
                                        )
                                        .animate(
                                          onPlay:
                                              (controller) => controller.repeat(
                                                reverse: true,
                                              ),
                                        )
                                        .scale(
                                          duration: const Duration(seconds: 1),
                                          begin: const Offset(1, 1),
                                          end: const Offset(1.1, 1.1),
                                        ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        viewModel.videolist[index].title,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        viewModel.videolist[index].description,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                            children: [
                                              Icon(
                                                viewModel
                                                            .videolist[index]
                                                            .videoType ==
                                                        VideoType.YOU_TUBE
                                                    ? Icons.videocam
                                                    : Icons.video_library,
                                                size: 16,
                                                color: Colors.grey[600],
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                viewModel
                                                            .videolist[index]
                                                            .videoType ==
                                                        VideoType.YOU_TUBE
                                                    ? 'youtube'
                                                    : 'vimeo',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ],
                                          )
                                          .animate()
                                          .fadeIn(
                                            delay: const Duration(
                                              milliseconds: 200,
                                            ),
                                          )
                                          .slideY(begin: 0.2, end: 0),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(
                          duration: const Duration(milliseconds: 600),
                          delay: Duration(milliseconds: 100 * index),
                        )
                        .slideY(begin: 0.2, end: 0)
                        .then()
                        .animate(
                          onPlay: (controller) => controller.loop(count: 1),
                          autoPlay: false,
                          target: index == 0 ? 1 : 0,
                        )
                        .shimmer(
                          duration: const Duration(seconds: 1),
                          color: Colors.blue.withValues(alpha: 0.3),
                        );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
