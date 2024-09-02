import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stackbud_test/core/config/route/app_pages.dart';
import 'package:stackbud_test/features/presentation/startup/splash_screen.dart';
import 'package:stackbud_test/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => GetMaterialApp(
        title: 'StackBud Test App',
        debugShowCheckedModeBanner: false,
        enableLog: true,
        home: const SplashScreen(),
        defaultTransition: Transition.fade,
        initialRoute: Routes.start,
        getPages: AppPages.pages,
      ),
    );
  }
}
