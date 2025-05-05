import 'package:axlpl_delivery/common_widget/error_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // OneSignal.initialize("ff262d3f-067a-4c80-a370-08f18ed8b4c2");
  // OneSignal.Notifications.requestPermission(false);

  runApp(
    ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      child: GetMaterialApp(
        enableLog: true,
        defaultTransition: Transition.fadeIn,
        title: "AXLPL Delivery",
        builder: (context, child) {
          ErrorWidget.builder = (errorDetails) {
            return ErrorScreen();
          };
          return child!;
        },
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(textTheme: GoogleFonts.workSansTextTheme()),
      ),
    ),
  );
}
