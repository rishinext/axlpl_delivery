import 'dart:developer';

import 'package:axlpl_delivery/app/modules/add_shipment/views/pageview_view.dart';
import 'package:axlpl_delivery/app/modules/bottombar/controllers/bottombar_controller.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/common_widget/home_container.dart';
import 'package:axlpl_delivery/common_widget/home_icon_container.dart';
import 'package:axlpl_delivery/common_widget/qr_scan_screen.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final bottomController = Get.put(BottombarController());
    final MobileScannerController QRController = MobileScannerController();
    final user = bottomController.userData.value;
    return Scaffold(
        backgroundColor: themes.lightWhite,
        appBar: AppBar(
          backgroundColor: themes.whiteColor,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: InkWell(
              onTap: () => Get.toNamed(Routes.PROFILE),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                      'assets/manimg.png',
                    )),
                    shape: BoxShape.circle),
              ),
            ),
          ),
          title: Image.asset(
            authLogo,
            width: 110.w,
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.NOTIFICATION);
                  },
                  icon: Icon(Icons.notifications_none),
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                ContainerTextfiled(
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: themes.grayColor,
                  ),
                  suffixIcon: InkWell(
                      onTap: () async {
                        String? res = await SimpleBarcodeScanner.scanBarcode(
                          scanType: ScanType.defaultMode,
                          context,
                          barcodeAppBar: const BarcodeAppBar(
                            appBarTitle: '',
                            centerTitle: false,
                            enableBackButton: true,
                            backButtonIcon: Icon(Icons.arrow_back_ios),
                          ),
                          isShowFlashIcon: true,
                          // delayMillis: 2000,
                          cameraFace: CameraFace.back,
                        );

                        final result = res as String;
                        log(result.toString());
                      },
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SimpleBarcodeScannerPage(
                      //       scanType: ScanType.barcode,
                      //     ),
                      //   ));

                      child: Icon(CupertinoIcons.qrcode_viewfinder)),
                  hintText: 'Enter Your Package Number',
                  controller: controller.searchController,
                ),
                user?.role == "messanger"
                    ? Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              return HomeContainer(
                                onTap: () {
                                  Get.toNamed(Routes.RUNNING_DELIVERY_DETAILS);
                                },
                                color: themes.blueGray,
                                title: runningDeliveryTxt,
                                subTitle: controller.isLoading.value
                                    ? controller
                                        .dashboardDataModel.value?.totalDelivery
                                        .toString()
                                    : '0'.toUpperCase(),
                              );
                            }),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Obx(() {
                              return HomeContainer(
                                color: themes.lightCream,
                                title: runningPickupTxt,
                                subTitle: controller.isLoading.value
                                    ? controller
                                        .dashboardDataModel.value?.totalPickup
                                        .toString()
                                    : '0'.toUpperCase(),
                              );
                            }),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                Obx(() {
                  if (bottomController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (bottomController.userData.value?.role == 'messanger') {
                    return Row(
                      children: [
                        Expanded(
                            child: HomeIconContainer(
                                title: 'Pickup',
                                Img: truckIcon,
                                OnTap: () => Get.toNamed(Routes.PICKUP))),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                            child: HomeIconContainer(
                                title: 'Delivery',
                                Img: deliveryIcon,
                                OnTap: () => Get.toNamed(Routes.DELIVERY,
                                    arguments: ''))),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                            child: HomeIconContainer(
                          title: 'POD',
                          Img: folderIcon,
                          OnTap: () => Get.toNamed(Routes.POD),
                        )),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
                Obx(() {
                  if (bottomController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return Row(
                    children: [
                      Expanded(
                          child: HomeIconContainer(
                        OnTap: () => Get.to(PageviewView()),
                        title: 'Add Shipment',
                        Img: trackingIcon,
                      )),
                      SizedBox(
                        width: 10.w,
                      ),
                      bottomController.userData.value?.role == 'messanger'
                          ? Expanded(
                              child: HomeIconContainer(
                              title: 'Consigment',
                              Img: containerIcon,
                              OnTap: () => Get.toNamed(Routes.CONSIGNMENT),
                            ))
                          : Expanded(
                              child: HomeIconContainer(
                              title: 'Show Shipment',
                              Img: containerIcon,
                              OnTap: () => Get.toNamed(Routes.SHIPNOW),
                            )),
                      SizedBox(
                        width: 10.w,
                      ),
                      if (bottomController.userData.value?.role == 'messanger')
                        Expanded(
                            child: HomeIconContainer(
                          OnTap: () => Get.toNamed(Routes.HISTORY),
                          title: 'History',
                          Img: history,
                        )),
                    ],
                  );
                }),
                Obx(() {
                  if (bottomController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (bottomController.userData.value?.role == 'messanger') {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: themes.whiteColor,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/manimg.png'),
                                ),
                                SizedBox(height: 8.h),
                                Obx(() {
                                  final user = bottomController.userData.value;
                                  if (user == null) return Text('N/A');

                                  final name = user.messangerdetail?.name ??
                                      user.customerdetail?.fullName ??
                                      'N/A';

                                  return SizedBox(
                                    width: 80.w,
                                    child: Text(
                                      name,
                                      style: themes.fontSize14_500,
                                    ),
                                  );
                                }),
                              ],
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: themes.blueGray,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 16.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Rating',
                                          style: themes.fontSize14_500,
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          '4.5',
                                          style: themes.fontSize18_600.copyWith(
                                            fontSize: 40.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '''Delivery's''',
                                          style: themes.fontSize14_500,
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          '110',
                                          style: themes.fontSize18_600.copyWith(
                                            fontSize: 40.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                })
              ],
            ),
          ),
        ));
  }
}
