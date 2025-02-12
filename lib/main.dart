import 'package:axlpl_delivery/common_widget/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      child: GetMaterialApp(
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
