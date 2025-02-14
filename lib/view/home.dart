import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lms_project/core/colors.dart';
import 'package:lms_project/core/constants.dart';
import 'package:lms_project/model/home_model.dart';
import 'package:lms_project/view/modules.dart';
import 'package:lms_project/viewmodels/home_viewmodel.dart';
import 'package:lms_project/widget/error_widget.dart';
import 'package:lms_project/widget/gradient_appbar.dart';
import 'package:lms_project/widget/loader_widget.dart';
import 'package:lms_project/widget/network_image_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeViewModel>(context, listen: false).fetchHome();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: StringConstants.appname,
        leading: Icon(Icons.menu, color: AppColors.white),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return loader();
          }
          if (viewModel.errorMessage != null) {
            return errorWidget(viewModel.errorMessage!);
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CarouselSliderWidget(),
                  CourseGridWidget(home: viewModel.homelsit),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

//gridview widget
class CourseGridWidget extends StatelessWidget {
  final List<Homemodel> home;
  const CourseGridWidget({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: home.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => Modules(id: home[i].id, module: home[i].title),
              ),
            );
          },
          child: Card(child: networkImageWidget(home[i].image)),
        );
      },
    );
  }
}

//slider section
class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://i.pinimg.com/736x/6a/11/13/6a1113d20d8d63a35a30e98c63da974c.jpg',
      'https://i.pinimg.com/736x/c3/a4/f0/c3a4f0d06287de60c85859cb3e6c21d0.jpg',
    ];

    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            spacing: 5,
            children: [
              CarouselSlider.builder(
                itemCount: imgList.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imgList[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 220,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) {
                    viewModel.updateIndex(index);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imgList.length,
                  (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          viewModel.currentIndex == index
                              ? AppColors.colorprimary
                              : AppColors.gradient_top,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
