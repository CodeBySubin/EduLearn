import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lms_project/core/utils/string_constants.dart';
import 'package:lms_project/view/course/course.dart';
import 'package:lms_project/view/home/widgets/course_status_section.dart';
import 'package:lms_project/view/home/widgets/featured_subject.dart';
import 'package:lms_project/view/home/widgets/hero_section.dart';
import 'package:lms_project/view/home/widgets/subjects_section.dart';
import 'package:lms_project/view/profile/profile.dart';
import 'package:lms_project/viewmodels/home_viewmodel.dart';
import 'package:lms_project/widget/error_widget.dart';
import 'package:lms_project/widget/loader_widget.dart';
import 'package:provider/provider.dart';

// Main home page
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeViewModel>(context, listen: false).fetchHome();
    });
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          StringConstants.appname,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E3A8A),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Color(0xFF1E3A8A)),
            onPressed: () {},
          ).animate().fade(duration: 300.ms).scale(delay: 150.ms),
          IconButton(
            icon: Icon(
              Icons.notifications_none_outlined,
              color: Color(0xFF1E3A8A),
            ),
            onPressed: () {},
          ).animate().fade(duration: 300.ms).scale(delay: 300.ms),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return loader();
          }
          if (viewModel.errorMessage != null) {
            return buildErrorWidget(
              context: context,
              message: viewModel.errorMessage!,
              onRetry: () {
                viewModel.fetchHome();
              },
            );
          }
          return _getSelectedScreen();
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Get the screen based on selected index
  Widget _getSelectedScreen() {
    final viewModel = Provider.of<HomeViewModel>(context);

    switch (viewModel.selectedIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return Course();
      case 2:
        return ProfilePage();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heroSection()
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.2, end: 0),
              curseStatsSection()
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 600.ms)
                  .slideY(begin: 0.2, end: 0),
              featuredSubjectsSection(viewModel.homelsit)
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 600.ms)
                  .slideY(begin: 0.2, end: 0),
              AllSubjectsSection(homemodel: viewModel.homelsit)
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 600.ms)
                  .slideY(begin: 0.2, end: 0),
              SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                0,
                Icons.home,
                'Home',
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
              _buildNavItem(1, Icons.menu_book, 'Courses')
                  .animate()
                  .fadeIn(delay: 100.ms, duration: 400.ms)
                  .slideY(begin: 0.2, end: 0),
              _buildNavItem(2, Icons.person, 'Profile')
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 400.ms)
                  .slideY(begin: 0.2, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        final isSelected = viewModel.selectedIndex == index;

        return InkWell(
          onTap: () {
            viewModel.updateSelectedIndex(index);
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                      icon,
                      color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey,
                    )
                    .animate(target: isSelected ? 1 : 0)
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.2, 1.2),
                      duration: 300.ms,
                    )
                    .then(delay: 100.ms)
                    .scale(
                      begin: const Offset(1.2, 1.2),
                      end: const Offset(1, 1),
                      duration: 300.ms,
                    ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey,
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
