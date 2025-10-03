// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:axlpl_delivery/utils/utils.dart';

class PickupWidget extends StatelessWidget {
  final String companyName;
  final String date;
  final String status;
  final String currentStatus;
  final String messangerName;
  final String address;
  final String shipmentID;
  final String cityName;
  final String? receiverCityName;
  final String mobile;
  final String? paymentType;
  final Color statusColor;
  final Color statusDotColor;
  final bool showPickupBtn;
  final bool showTrasferBtn;
  final bool showDivider;
  final bool? isShowPaymentType;
  final isShowMessenger;
  final VoidCallback? pickUpTap;
  final VoidCallback? trasferTap;
  final Color? transferBtnColor;
  final Color? transferBorderColor;
  final Color? transferTextColor;
  final VoidCallback? openDialerTap;
  final VoidCallback? openMapTap;
  final VoidCallback? onTap;
  final pickupTxt;
  final networkImg;
  final toPayIcon;

  const PickupWidget({
    Key? key,
    required this.companyName,
    required this.date,
    required this.status,
    required this.currentStatus,
    required this.messangerName,
    required this.address,
    required this.shipmentID,
    required this.cityName,
    required this.receiverCityName,
    required this.mobile,
    this.paymentType,
    required this.statusColor,
    required this.statusDotColor,
    required this.showPickupBtn,
    required this.showTrasferBtn,
    required this.showDivider,
    this.isShowMessenger = false,
    this.pickUpTap,
    this.trasferTap,
    this.transferBtnColor,
    this.transferBorderColor,
    this.transferTextColor,
    this.openDialerTap,
    this.openMapTap,
    this.onTap,
    this.pickupTxt,
    this.networkImg,
    this.isShowPaymentType,
    this.toPayIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Row: Timeline + Info
        InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// First Row: Shipment ID, Date, Divider
              Row(
                children: [
                  Text(
                    'SID: $shipmentID',
                    style: themes.fontSize14_500.copyWith(fontSize: 13.sp),
                    overflow: TextOverflow.fade,
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: shipmentID.toString()));
                    },
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(
                      Icons.copy,
                      size: 16.sp,
                    ),
                  ),
                  Spacer(),
                  Text(date,
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w600)),
                ],
              ),

              Divider(thickness: 1.h, height: 1.h),

              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.clip,
                      companyName,
                      style: themes.fontSize14_500.copyWith(
                          fontSize: 12.5.sp, color: themes.darkCyanBlue),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 4.w),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 5),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: Colors.orange[900],
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              /// Address below company name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.fade,
                      address,
                      style: themes.fontSize14_500
                          .copyWith(fontSize: 12.5.sp, color: themes.grayColor),
                    ),
                  ),
                  InkWell(
                    onTap: openMapTap,
                    child: CircleAvatar(
                        radius: 14.r,
                        backgroundColor: themes.blueGray,
                        child: Icon(Icons.gps_fixed,
                            size: 16.sp, color: themes.darkCyanBlue)),
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              /// Dotted Line as Row (Source to Destination)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 14.r,
                      backgroundColor: themes.blueGray,
                      child: Container(
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: themes.darkCyanBlue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: DottedLine(
                        direction: Axis.horizontal,
                        dashLength: 4,
                        dashGapLength: 4,
                        lineThickness: 2,
                        dashColor: themes.darkCyanBlue,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    CircleAvatar(
                        radius: 14.r,
                        backgroundColor: themes.blueGray,
                        child: Icon(Icons.location_on,
                            size: 16.sp, color: themes.darkCyanBlue)),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        cityName,
                        style: themes.fontSize14_500.copyWith(fontSize: 12.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: themes.blueGray,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        currentStatus,
                        style: themes.fontSize14_500.copyWith(
                          fontSize: 12.sp,
                          color: themes.darkCyanBlue,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        receiverCityName ?? '',
                        style: themes.fontSize14_500.copyWith(fontSize: 12.sp),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),

              /// Messenger Info and Call Button

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),

                  /// City Name and Insurance
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 14.r,
                        backgroundColor: themes.blueGray,
                        child: Icon(Icons.location_on,
                            size: 16.sp, color: themes.darkCyanBlue),
                      ),
                      SizedBox(width: 6.w),
                      Text(cityName, style: TextStyle(fontSize: 12.sp)),
                      Spacer(),
                      Image.asset(
                        axlplLogo,
                        width: 20.w,
                      ),
                      SizedBox(width: 10.w),
                      SizedBox(
                        width: isShowPaymentType == true ? 80.w : null,
                        child: Text(
                          'Insurance',
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      if (isShowPaymentType == true) ...[
                        SizedBox(width: 10.w),
                        CircleAvatar(
                          backgroundColor: themes.blueGray,
                          radius: 14.r,
                          child: Icon(toPayIcon ?? Icons.payment,
                              size: 16.sp, color: themes.darkCyanBlue),
                        ),
                        SizedBox(width: 4.w),
                        Text(paymentType ?? 'N/A',
                            style: TextStyle(fontSize: 12.sp)),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 12.h),
        showDivider ? Divider(thickness: 1.h) : SizedBox(),

        /// Action Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showTrasferBtn
                ? OutlinedButton(
                    onPressed: trasferTap,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: transferBtnColor,
                      side: BorderSide(
                          color: transferBorderColor ?? themes.whiteColor,
                          width: 1.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    ),
                    child: Text(
                      'Transfer',
                      style: themes.fontSize18_600.copyWith(
                        fontSize: 14.sp,
                        color: transferTextColor,
                      ),
                    ),
                  )
                : SizedBox(),
            showPickupBtn
                ? ElevatedButton(
                    onPressed: pickUpTap,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: themes.whiteColor,
                      backgroundColor: themes.darkCyanBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
                    ),
                    child: Text(pickupTxt ?? '',
                        style: TextStyle(fontSize: 13.sp)),
                  )
                : SizedBox()
          ],
        ),
        SizedBox(height: 12.h),
        isShowMessenger
            ? Row(
                children: [
                  CircleAvatar(
                    radius: 8.r,
                    backgroundImage: NetworkImage(
                      networkImg ?? personImg,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: openDialerTap,
                    child: Text(
                      messangerName,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
