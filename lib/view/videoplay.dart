import 'package:flutter/material.dart';
import 'package:lms_project/model/video_model.dart';
import 'package:lms_project/viewmodels/video_viewmodel.dart';
import 'package:lms_project/widget/video_player_widget.dart';
import 'package:provider/provider.dart';

class OptimizedVideoPlayer extends StatefulWidget {
  final Videomodel video;

  const OptimizedVideoPlayer({super.key, required this.video});

  @override
  State<OptimizedVideoPlayer> createState() => _OptimizedVideoPlayerState();
}

class _OptimizedVideoPlayerState extends State<OptimizedVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<VideoViewmodel>(
        builder: (context, viewModel, child) {
          return VideoPlayerWidget(
            key: ValueKey(viewModel.videwModel!.videoUrl),
            platform: viewModel.videwModel!.videoType,
            videoId: viewModel.videwModel!.videoUrl
                .replaceAll("https://www.youtube.com/watch?v=", "")
                .replaceAll("https://vimeo.com/", ""),
          );
        },
      ),
    );
  }
}
