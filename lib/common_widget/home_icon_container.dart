import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeIconContainer extends StatelessWidget {
  String? title;
  final Img;
  final OnTap;
  HomeIconContainer({
    super.key,
    this.title,
    this.Img,
    this.OnTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: OnTap,
      child: Container(
        decoration: BoxDecoration(
            color: themes.whiteColor, borderRadius: BorderRadius.circular(5.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? 'N/A',
                overflow: TextOverflow.fade,
                style: themes.fontSize14_500,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    Img,
                    width: 30.w,
                  ),
                  CircleAvatar(
                    backgroundColor: themes.lightCream,
                    radius: 15,
                    child: Icon(Icons.arrow_forward),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
