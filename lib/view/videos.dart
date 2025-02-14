import 'package:flutter/material.dart';
import 'package:lms_project/core/colors.dart';
import 'package:lms_project/core/constants.dart';
import 'package:lms_project/utils/screensize.dart';
import 'package:lms_project/view/videoplay.dart';
import 'package:lms_project/viewmodels/video_viewmodel.dart';
import 'package:lms_project/widget/error_widget.dart';
import 'package:lms_project/widget/gradient_appbar.dart';
import 'package:lms_project/widget/loader_widget.dart';
import 'package:provider/provider.dart';

class Videos extends StatefulWidget {
  final int moduleid;
  const Videos({super.key, required this.moduleid});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VideoViewmodel>(
        context,
        listen: false,
      ).fetchvideos(widget.moduleid);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = ScreenSize.height(context);
    return Consumer<VideoViewmodel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return loader();
        }
        if (viewModel.errorMessage != null) {
          return errorWidget(viewModel.errorMessage!);
        }
        return Scaffold(
          appBar: GradientAppBar(
            title: StringConstants.videos,
            backbutton: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: height * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: OptimizedVideoPlayer(video: viewModel.videwModel!),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.videolist.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          viewModel.updateVideo(viewModel.videwModel!);
                        },

                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),

                          color: AppColors.gradient_top,
                          elevation: 0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              spacing: 5,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      viewModel.updateVideo(
                                        viewModel.videolist[index],
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        viewModel.videolist[index].title,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        viewModel.videolist[index].description,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
