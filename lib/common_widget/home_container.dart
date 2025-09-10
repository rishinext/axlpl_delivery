import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeContainer extends StatelessWidget {
  Color? color;
  String? title;
  String? subTitle;
  final VoidCallback? onTap;
  bool isIcon;
  HomeContainer({
    super.key,
    this.color,
    this.title,
    this.subTitle,
    this.onTap,
    this.isIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(5.r)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? 'N/A',
                style: themes.fontSize14_500,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(subTitle ?? 'N/A',
                      style: themes.fontSize18_600.copyWith(
                          fontSize: 40.sp, fontWeight: FontWeight.w700)),
                  isIcon
                      ? CircleAvatar(
                          backgroundColor: themes.whiteColor,
                          radius: 15,
                          child: Icon(Icons.arrow_forward),
                        )
                      : Container()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
