import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lms_project/core/utils/helper.dart';
import 'package:lms_project/model/video_model.dart';
import 'package:lms_project/viewmodels/video_viewmodel.dart';
import 'package:lms_project/widget/error_widget.dart';
import 'package:lms_project/widget/loader_widget.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final Videomodel video;

  const VideoPlayerPage({super.key, required this.video});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _youtubeController;
  late String _vimeoVideoId;
  bool _isYouTube = true;

  @override
  void initState() {
    super.initState();
    _isYouTube = widget.video.videoType == VideoType.YOU_TUBE;

    if (_isYouTube) {
      // Extract video ID from URL
      final videoId =
          YoutubePlayer.convertUrlToId(widget.video.videoUrl) ??
          'dQw4w9WgXcQ'; // Default video id

      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          enableCaption: true,
        ),
      );
    } else {
      // Extract Vimeo video ID from URL
      _vimeoVideoId = _extractVimeoId(widget.video.videoUrl);
    }
  }

  // Function to extract Vimeo video ID from URL
  String _extractVimeoId(String url) {
    // Handle different Vimeo URL formats
    final RegExp regExp = RegExp(
      r'(?:vimeo\.com\/|player\.vimeo\.com\/video\/)(\d+)',
      caseSensitive: false,
    );
    final match = regExp.firstMatch(url);
    
    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? '';
    }
    
    // If we can't extract the ID, return the full URL
    // The Vimeo player will try to handle it
    return url;
  }

  @override
  void dispose() {
    if (_isYouTube) {
      _youtubeController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.title)
            .animate()
            .fadeIn(duration: const Duration(milliseconds: 500)),
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
            return errorWidget(viewModel.errorMessage!);
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video Player with animation
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _isYouTube
                      ? YoutubePlayer(
                          controller: _youtubeController,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.blue,
                          progressColors: const ProgressBarColors(
                            playedColor: Colors.blue,
                            handleColor: Colors.blueAccent,
                          ),
                        )
                      : VimeoPlayer(
                          videoId: _vimeoVideoId,
                        ),
                )
                    .animate()
                    .fadeIn(duration: const Duration(milliseconds: 800))
                    .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),

                // Video information
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.video.title,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                          .animate()
                          .fadeIn(
                            delay: const Duration(milliseconds: 300),
                            duration: const Duration(milliseconds: 500),
                          )
                          .slideX(begin: 0.2, end: 0),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            _isYouTube ? Icons.videocam : Icons.video_library,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _isYouTube ? 'YouTube' : 'Vimeo',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      )
                          .animate()
                          .fadeIn(
                            delay: const Duration(milliseconds: 400),
                            duration: const Duration(milliseconds: 500),
                          )
                          .slideX(begin: 0.2, end: 0),
                      const SizedBox(height: 16),
                      const Divider()
                          .animate()
                          .fadeIn(
                            delay: const Duration(milliseconds: 500),
                            duration: const Duration(milliseconds: 500),
                          )
                          .slideY(begin: 0.2, end: 0),
                      const SizedBox(height: 16),
                      Text(
                        'Description',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                          .animate()
                          .fadeIn(
                            delay: const Duration(milliseconds: 600),
                            duration: const Duration(milliseconds: 500),
                          )
                          .slideX(begin: 0.2, end: 0),
                      const SizedBox(height: 8),
                      Text(
                        widget.video.description,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      )
                          .animate()
                          .fadeIn(
                            delay: const Duration(milliseconds: 700),
                            duration: const Duration(milliseconds: 500),
                          )
                          .slideX(begin: 0.2, end: 0),
                      const SizedBox(height: 24),

                      // Related videos
                      Text(
                        'Related Videos',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                          .animate()
                          .fadeIn(
                            delay: const Duration(milliseconds: 800),
                            duration: const Duration(milliseconds: 500),
                          )
                          .slideX(begin: 0.2, end: 0),
                      const SizedBox(height: 16),
                      _buildRelatedVideos(viewModel.videolist),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRelatedVideos(List<Videomodel> videos) {
    final relatedVideos =
        videos.where((v) => v.id != widget.video.id).take(3).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: relatedVideos.length,
      itemBuilder: (context, index) {
        final video = relatedVideos[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPlayerPage(video: video),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    getVideoThumbnail(video.videoUrl),
                    width: 120,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                )
                    .animate()
                    .fadeIn(duration: const Duration(milliseconds: 400))
                    .scale(
                      begin: const Offset(0.95, 0.95),
                      end: const Offset(1, 1),
                    ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            video.videoType == VideoType.YOU_TUBE
                                ? Icons.videocam
                                : Icons.video_library,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            video.videoType == VideoType.YOU_TUBE
                                ? 'YouTube'
                                : 'Vimeo',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
            .animate()
            .fadeIn(
              delay: Duration(milliseconds: 900 + (index * 200)),
              duration: const Duration(milliseconds: 500),
            )
            .slideY(begin: 0.2, end: 0)
            .animate(onPlay: (controller) => controller.repeat(reverse: true, count: 1))
            .shimmer(
              color: Colors.blue.withValues(alpha:0.1),
              size: 0.9,
              duration: const Duration(milliseconds: 1500),
            );
      },
    );
  }
}