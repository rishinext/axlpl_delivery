import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatelessWidget {
  String title;
  final VoidCallback? onPressed;
  CommonButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        color: themes.darkCyanBlue,
        focusColor: themes.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        onPressed: onPressed,
        child: Text(
          title,
          style: themes.fontReboto16_600.copyWith(color: themes.whiteColor),
        ),
      ),
    );
  }
}
