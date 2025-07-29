import 'dart:io';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar commonAppbar(String title) {
  if (Platform.isIOS) {
    // iOS Cupertino App Bar styling
    return AppBar(
      title: Text(title),
      titleTextStyle: themes.fontSize18_600.copyWith(
        fontSize: 16.sp,
        color: themes.whiteColor,
      ),
      centerTitle: true,
      backgroundColor: themes.darkCyanBlue,
      foregroundColor: themes.whiteColor,
      iconTheme: IconThemeData(
        color: themes.whiteColor,
      ),
      actionsIconTheme: IconThemeData(
        color: themes.whiteColor,
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
    );
  } else {
    // Android Material App Bar styling
    return AppBar(
      title: Text(title),
      titleTextStyle: themes.fontSize18_600
          .copyWith(fontSize: 16.sp, color: themes.blackColor),
      centerTitle: true,
    );
  }
}
