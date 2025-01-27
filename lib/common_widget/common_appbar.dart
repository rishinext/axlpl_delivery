import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar commonAppbar(String title) {
  return AppBar(
    title: Text(title),
    titleTextStyle: themes.fontSize18_600
        .copyWith(fontSize: 16.sp, color: themes.blackColor),
    centerTitle: true,
  );
}
