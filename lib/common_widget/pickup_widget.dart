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
  final String messangerName;
  final String address;
  final String shipmentID;
  final String cityName;
  final String mobile;
  final String? paymentType;
  final Color statusColor;
  final Color statusDotColor;
  final bool showPickupBtn;
  final bool showTrasferBtn;
  final bool showDivider;
  final bool? isShowPaymentType;
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

  const PickupWidget({
    Key? key,
    required this.companyName,
    required this.date,
    required this.status,
    required this.messangerName,
    required this.address,
    required this.shipmentID,
    required this.cityName,
    required this.mobile,
    this.paymentType,
    required this.statusColor,
    required this.statusDotColor,
    required this.showPickupBtn,
    required this.showTrasferBtn,
    required this.showDivider,
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
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Timeline Icons
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 14.r,
                        backgroundColor: themes.blueGray,
                        child: Icon(Icons.gps_fixed_sharp,
                            size: 16.sp, color: themes.darkCyanBlue),
                      ),
                      SizedBox(height: 8.h),
                      SizedBox(
                        height: 60.h,
                        child: DottedLine(
                          direction: Axis.vertical,
                          dashLength: 4,
                          dashGapLength: 4,
                          lineThickness: 2,
                          dashColor: themes.darkCyanBlue,
                        ),
                      ),
                      SizedBox(height: 8.h),
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
                    ],
                  ),
                  SizedBox(width: 12.w),

                  /// Info Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title, Date & Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                companyName,
                                style: themes.fontSize14_500
                                    .copyWith(fontSize: 12.5.sp),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(date, style: TextStyle(fontSize: 11.sp)),
                                Row(
                                  children: [
                                    Container(
                                      width: 6.w,
                                      height: 6.w,
                                      decoration: BoxDecoration(
                                        color: statusDotColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      status,
                                      style: TextStyle(
                                        color: statusColor,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),

                        /// Messenger Info
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15.r,
                              backgroundImage: NetworkImage(
                                networkImg ?? personImg,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('Messenger', style: themes.fontSize14_400),
                                Text(
                                  messangerName,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            IconButton.outlined(
                                onPressed: openDialerTap,
                                icon: Icon(Icons.call))
                          ],
                        ),
                        SizedBox(height: 10.h),

                        /// Address Info
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                address,
                                style: themes.fontSize14_500
                                    .copyWith(fontSize: 14.sp),
                              ),
                            ),
                            IconButton.filledTonal(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(themes.blueGray),
                              ),
                              onPressed: openMapTap,
                              icon: Icon(Icons.gps_fixed),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'ID: $shipmentID',
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black54),
                            ),
                            IconButton(
                                onPressed: () {
                                  Clipboard.setData(new ClipboardData(
                                      text: shipmentID.toString()));
                                },
                                icon: Icon(
                                  Icons.copy,
                                  size: 15.sp,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              /// Location, Phone, Payment
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                    ],
                  ),

                  // Container(
                  //   width: 6.w,
                  //   height: 6.w,
                  //   decoration: BoxDecoration(
                  //     color: statusDotColor,
                  //     shape: BoxShape.circle,
                  //   ),
                  // ),
                  Spacer(),
                  Image.asset(
                    axlplLogo,
                    width: 20.w,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                    width: isShowPaymentType == true ? 80.w : null,
                    child: Text(
                      'Insurance',
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  /*    InkWell(
                    onTap: openDialerTap,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: themes.lightCream,
                          radius: 14.r,
                          child: Icon(
                            Icons.phone,
                            size: 16.sp,
                            color: themes.redColor,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          mobile,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),*/
                  if (isShowPaymentType == true)
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: themes.blueGray,
                          radius: 14.r,
                          child: Icon(Icons.credit_card,
                              size: 16.sp, color: Colors.indigo),
                        ),
                        SizedBox(width: 4.w),
                        Text(paymentType ?? 'N/A',
                            style: TextStyle(fontSize: 12.sp)),
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
        )
      ],
    );
  }
}
