import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CommonButton extends StatelessWidget {
  String title;
  final bool? isLoading;
  final VoidCallback? onPressed;
  CommonButton(
      {super.key, required this.title, this.onPressed, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        color: themes.darkCyanBlue,
        focusColor: themes.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        onPressed: onPressed,
        child: SizedBox(
          height: 24, // Set a fixed height
          child: isLoading == true
              ? Center(
                  child: SizedBox(
                    height: 16, // Adjust this size to match text height
                    width: 16, // Keep width equal to height for proper scaling
                    child: SpinKitCubeGrid(
                      color: themes.whiteColor,
                      size: 16, // Ensure size remains small
                    ),
                  ),
                )
              : Text(
                  title,
                  style: themes.fontReboto16_600
                      .copyWith(color: themes.whiteColor),
                ),
        ),
      ),
    );
  }
}
