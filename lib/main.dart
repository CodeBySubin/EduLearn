import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lms_project/core/colors.dart';
import 'package:lms_project/core/constants.dart';
import 'package:lms_project/view/splash.dart';
import 'package:lms_project/viewmodels/home_viewmodel.dart';
import 'package:lms_project/viewmodels/modules_viewmodel.dart';
import 'package:lms_project/viewmodels/video_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ModulesViewmodel()),
        ChangeNotifierProvider(create: (_) => VideoViewmodel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringConstants.appname,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: AppColors.colorprimary,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorprimary),
          useMaterial3: true,
        ),
        home: const Splash(),
      ),
    );
  }
}
