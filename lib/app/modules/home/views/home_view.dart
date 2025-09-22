import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/pageview_view.dart';
import 'package:axlpl_delivery/app/modules/bottombar/controllers/bottombar_controller.dart';
import 'package:axlpl_delivery/app/modules/delivery/controllers/delivery_controller.dart';
import 'package:axlpl_delivery/app/modules/history/controllers/history_controller.dart';
import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/controllers/running_delivery_details_controller.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/app/modules/pod/controllers/pod_controller.dart';
import 'package:axlpl_delivery/app/modules/profile/controllers/profile_controller.dart';
import 'package:axlpl_delivery/app/modules/shipment_record/controllers/shipment_record_controller.dart';
import 'package:axlpl_delivery/app/modules/shipnow/controllers/shipnow_controller.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/common_widget/contract_home_screen_widget.dart';
import 'package:axlpl_delivery/common_widget/contract_list.dart';
import 'package:axlpl_delivery/common_widget/home_container.dart';
import 'package:axlpl_delivery/common_widget/home_icon_container.dart';
import 'package:axlpl_delivery/common_widget/contract_details_screen.dart';
import 'package:axlpl_delivery/common_widget/my_invoices_list.dart';
import 'package:axlpl_delivery/common_widget/pdf_view.dart';
import 'package:axlpl_delivery/common_widget/used_contract_shipment.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    final bottomController = Get.put(BottombarController());
    final pickupController = Get.put(PickupController());
    final deliveryController = Get.put(DeliveryController());
    final runningPickupDetailsController =
        Get.put(RunningDeliveryDetailsController());
    final profileController = Get.put(ProfileController());
    final shipmentRecordController = Get.put(ShipmentRecordController());
    final podController = Get.put(PodController());
    final historyController = Get.put(HistoryController());
    final shipnowController = Get.put(ShipnowController());

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
                child: Obx(() {
                  if (profileController.isProfileLoading.value ==
                      Status.loading) {
                    return Container(
                      width: 40, // Ensure loader has a size
                      height: 40,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2),
                      ),
                      child: Center(
                        child: const CircularProgressIndicator.adaptive(
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  } else {
                    // 2. Once loading is complete, use your existing logic to show the image
                    String? networkImageUrl;

                    if (bottomController.userData.value?.role == 'messanger') {
                      final messangerPath = profileController
                          .messangerDetail.value?.messangerdetail?.path;
                      final messangerPhoto = profileController
                          .messangerDetail.value?.messangerdetail?.photo;
                      if (messangerPath != null &&
                          messangerPhoto != null &&
                          messangerPath.trim().isNotEmpty &&
                          messangerPhoto.trim().isNotEmpty) {
                        networkImageUrl = "$messangerPath$messangerPhoto";
                      }
                    } else {
                      final customerPath =
                          profileController.customerDetail.value?.path;
                      final customerPhoto = profileController
                          .customerDetail.value?.custProfileImg;
                      if (customerPath != null &&
                          customerPhoto != null &&
                          customerPath.trim().isNotEmpty &&
                          customerPhoto.trim().isNotEmpty) {
                        networkImageUrl = "$customerPath$customerPhoto";
                      }
                    }

                    DecorationImage? decorationImage;
                    if (networkImageUrl != null &&
                        networkImageUrl.isNotEmpty &&
                        networkImageUrl.trim() != '') {
                      decorationImage = DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(networkImageUrl),
                        onError: (exception, stackTrace) {
                          // Utils().log("Error loading image: $exception");
                          print("Error loading image: $exception");
                        },
                      );
                    }

                    return Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: decorationImage == null
                            ? Colors.grey.shade300
                            : null,
                        image: decorationImage,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: themes.darkCyanBlue, width: 2),
                      ),
                      child: decorationImage == null
                          ? Icon(
                              Icons.person,
                              size: 20,
                              color: themes.darkCyanBlue,
                            )
                          : null,
                    );
                  }
                })),
          ),
          title: Image.asset(
            authLogo,
            width: Platform.isIOS ? 25.w : 45.w,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 0,
              children: [
                ContainerTextfiled(
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: themes.grayColor,
                  ),
                  suffixIcon: InkWell(
                      onTap: () async {
                        var scannedValue =
                            await Utils().scanAndPlaySound(context);
                        if (scannedValue != null && scannedValue != '-1') {
                          homeController.searchController.text = scannedValue;

                          Get.dialog(
                            const Center(
                                child: CircularProgressIndicator.adaptive()),
                            barrierDismissible: false,
                          );

                          // await shipmentRecordController
                          //     .getShipmentRecord(scannedValue);
                          await runningPickupDetailsController
                              .fetchTrackingData(scannedValue);
                          Get.back(); // Close the dialog
                          Get.toNamed(
                            Routes.RUNNING_DELIVERY_DETAILS,
                            arguments: {
                              'shipmentID': scannedValue,
                              // 'status': data.status.toString(),
                              // 'invoicePath': data.invoicePath,
                              // 'invoicePhoto': data.invoiceFile,
                              // 'paymentMode': data.paymentMode,
                              // 'date': data.date,
                              // 'cashAmt': data.totalCharges
                            },
                          );
                        }
                      },
                      child: Icon(CupertinoIcons.qrcode_viewfinder)),
                  hintText: 'Enter Your Package Number',
                  controller: shipmentRecordController.shipmentController,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Obx(() {
                  var contracts = homeController
                      .customerDashboardDataModel.value?.contracts;
                  var data = (contracts != null && contracts.isNotEmpty)
                      ? contracts.first
                      : null;

                  return bottomController.userData.value?.role != 'messanger'
                      ? ContractCard(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UsedContractShipment(),
                                ));
                          },
                          title: data?.categoryName ?? 'N/A',
                          used: double.tryParse(data?.usedValue ?? '0') ?? 0,
                          total:
                              double.tryParse(data?.assignedValue ?? '0') ?? 0,
                        )
                      : SizedBox();
                }),
                SizedBox(
                  height: 15.h,
                ),
                Obx(
                  () {
                    if (bottomController.userData.value?.role == 'messanger') {
                      return Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              return HomeContainer(
                                onTap: () {
                                  deliveryController.getDeliveryData();
                                  deliveryController.fetchPaymentModes();
                                  historyController.getDeliveryHistory();
                                  Get.toNamed(Routes.DELIVERY);
                                },
                                color: themes.blueGray,
                                title: runningDeliveryTxt,
                                subTitle: homeController.isLoading.value
                                    ? '...'
                                    : homeController.dashboardDataModel.value
                                            ?.totalDelivery
                                            ?.toString() ??
                                        '0',
                              );
                            }),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Obx(() {
                              return HomeContainer(
                                onTap: () {
                                  pickupController.getPickupData();
                                  historyController.getPickupHistory();
                                  pickupController.fetchPaymentModes();
                                  Get.toNamed(Routes.PICKUP);
                                },
                                color: themes.lightCream,
                                title: runningPickupTxt,
                                subTitle: homeController.isLoading.value
                                    ? '...'
                                    : homeController.dashboardDataModel.value
                                            ?.totalPickup
                                            ?.toString() ??
                                        '0',
                              );
                            }),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        spacing: 10,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return HomeContainer(
                                    onTap: () {
                                      Get.toNamed(Routes.SHIPMENT_RECORD);
                                    },
                                    color: themes.blueGray,
                                    title: 'Out for Delivery',
                                    subTitle: homeController
                                                .isCustomerDashboard.value ==
                                            Status.loading
                                        ? '...'
                                        : homeController
                                                .customerDashboardDataModel
                                                .value
                                                ?.outForDeliveryCount
                                                ?.toString() ??
                                            '0',
                                  );
                                }),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Obx(() {
                                  return HomeContainer(
                                      onTap: () {
                                        Get.toNamed(Routes.SHIPMENT_RECORD);
                                      },
                                      color: themes.blueGray,
                                      title: 'Pickedup',
                                      subTitle: homeController
                                                  .isCustomerDashboard.value ==
                                              Status.loading
                                          ? '...' // This part works
                                          : homeController
                                                  .customerDashboardDataModel
                                                  .value
                                                  ?.pickedupCount
                                                  ?.toString() ??
                                              '0' // This results in ',
                                      );
                                }),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return HomeContainer(
                                    onTap: () {
                                      Get.toNamed(Routes.SHIPMENT_RECORD);
                                    },
                                    color: themes.blueGray,
                                    title: 'Wating for Pickup',
                                    subTitle: homeController
                                                .isCustomerDashboard.value ==
                                            Status.loading
                                        ? '...'
                                        : homeController
                                                .customerDashboardDataModel
                                                .value
                                                ?.waitingForPickupCount
                                                ?.toString() ??
                                            '0',
                                  );
                                }),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Obx(() {
                                  return HomeContainer(
                                    onTap: () {
                                      Get.toNamed(Routes.SHIPMENT_RECORD);
                                    },
                                    color: themes.blueGray,
                                    title: 'shipped',
                                    subTitle: homeController
                                                .isCustomerDashboard.value ==
                                            Status.loading
                                        ? '...'
                                        : homeController
                                                .customerDashboardDataModel
                                                .value
                                                ?.shippedCount
                                                ?.toString() ??
                                            '0',
                                  );
                                }),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
                Obx(() {
                  if (bottomController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (bottomController.userData.value?.role == 'messanger') {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: HomeIconContainer(
                                    title: 'Pickups',
                                    Img: truckIcon,
                                    OnTap: () {
                                      pickupController.getPickupData();
                                      pickupController.fetchPaymentModes();
                                      pickupController.getMessangerData(user
                                              ?.messangerdetail?.routeId
                                              .toString() ??
                                          '0');
                                      Get.toNamed(Routes.PICKUP);
                                    })),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                                child: HomeIconContainer(
                                    title: 'Delivery',
                                    Img: deliveryIcon,
                                    OnTap: () {
                                      deliveryController.getDeliveryData();
                                      deliveryController.fetchPaymentModes();
                                      historyController.getDeliveryHistory();
                                      Get.toNamed(Routes.DELIVERY,
                                          arguments: '');
                                    })),
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
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
                SizedBox(
                  height: 15.h,
                ),
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
                              title: 'My Shipment',
                              Img: containerIcon,
                              OnTap: () => Get.toNamed(Routes.SHIPNOW),
                            )),
                      SizedBox(
                        width: 10.w,
                      ),
                      Obx(
                        () {
                          return bottomController.userData.value?.role ==
                                  'messanger'
                              ? SizedBox(
                                  width: 100.w,
                                  child: HomeIconContainer(
                                    title: 'My Shipment',
                                    Img: containerIcon,
                                    OnTap: () => Get.toNamed(Routes.SHIPNOW),
                                  ),
                                )
                              : SizedBox.shrink();
                        },
                      ),
                      Obx(
                        () =>
                            bottomController.userData.value?.role == 'messanger'
                                ? SizedBox.shrink()
                                : SizedBox(
                                    width: 100.w,
                                    child: HomeIconContainer(
                                      title: 'My Contracts',
                                      Img: contractLogo,
                                      OnTap: () {
                                        // homeController.contractView();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ContractListWidget()
                                              // PdfViewerPage(
                                              //   pdfUrl: homeController
                                              //           .contractDataModel
                                              //           .value
                                              //           ?.contracts?[0]
                                              //           .viewLink ??
                                              //       '',
                                              // ),
                                              ),
                                        );
                                      },
                                    ),
                                  ),
                      ),
                    ],
                  );
                }),
                Obx(
                  () {
                    if (bottomController.userData.value?.role == 'messanger') {
                      return SizedBox(
                        width: 100.w,
                        child: HomeIconContainer(
                          OnTap: () {
                            historyController.getCashCollectionHistory();
                            Get.toNamed(Routes.HISTORY);
                          },
                          title: 'Cash Collection',
                          Img: history,
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Obx(
                  () => bottomController.userData.value?.role == 'messanger'
                      ? SizedBox.shrink()
                      : SizedBox(
                          width: 100.w,
                          child: HomeIconContainer(
                            title: 'My Invoices',
                            Img: invoiceLogo,
                            OnTap: () {
                              homeController.invoiceList();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyInvoicesList()
                                    // PdfViewerPage(
                                    //   pdfUrl: homeController
                                    //           .contractDataModel
                                    //           .value
                                    //           ?.contracts?[0]
                                    //           .viewLink ??
                                    //       '',
                                    // ),
                                    ),
                              );
                            },
                          ),
                        ),
                ),
                Obx(() {
                  final imageUrl = () {
                    final messangerPath = profileController
                        .messangerDetail.value?.messangerdetail?.path;
                    final messangerPhoto = profileController
                        .messangerDetail.value?.messangerdetail?.photo;

                    if (messangerPath != null &&
                        messangerPhoto != null &&
                        messangerPath.trim().isNotEmpty &&
                        messangerPhoto.trim().isNotEmpty) {
                      return "$messangerPath$messangerPhoto";
                    }
                    return null;
                  }();

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
                                  backgroundColor: themes.grayColor,
                                  backgroundImage:
                                      imageUrl != null && imageUrl.isNotEmpty
                                          ? NetworkImage(imageUrl)
                                          : null,
                                  child: imageUrl == null || imageUrl.isEmpty
                                      ? Icon(
                                          Icons.person,
                                          size: 30,
                                          color: themes.darkCyanBlue,
                                        )
                                      : null,
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
                                        homeController.isRattingData.value ==
                                                Status.loading
                                            ? Center(
                                                child: Text(
                                                '0.0',
                                                style: themes.fontSize18_600
                                                    .copyWith(
                                                  fontSize: 40.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ))
                                            : Text(
                                                homeController.rattingDataModel
                                                        .value?.averageRating
                                                        ?.toStringAsFixed(1) ??
                                                    '0.0',
                                                style: themes.fontSize18_600
                                                    .copyWith(
                                                  fontSize: 40.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
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
                                          homeController.rattingDataModel.value
                                                  ?.deliveredCount
                                                  .toString() ??
                                              '0',
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
                }),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  if (shipnowController.isLoadingShipNow.value) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }

                  // Parse today's shipments
                  final allShipments = shipnowController.allShipmentData;
                  final today = DateTime.now();
                  final todayShipments = allShipments.where((shipment) {
                    final created = shipment.createdDate;
                    if (created == null) return false;

                    // Normalize (compare only year, month, day)
                    return created.year == today.year &&
                        created.month == today.month &&
                        created.day == today.day;
                  }).toList();

                  if (todayShipments.isNotEmpty) {
                    return ListView.separated(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: todayShipments.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 15.h),
                      itemBuilder: (context, index) {
                        final shipment = todayShipments[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: themes.whiteColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Text(
                                '${shipment.shipmentId}',
                                style: themes.fontSize14_500.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                        text: shipment.shipmentId.toString()),
                                  );
                                },
                                icon: const Icon(Icons.copy, size: 18),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: themes.blueGray,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  shipment.shipmentStatus.toString(),
                                  style: themes.fontSize14_500.copyWith(
                                    color: themes.darkCyanBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  return Center(
                      child: Text(
                    "No shipments created today",
                    style: themes.fontSize14_500,
                  ));
                }),
              ],
            ),
          ),
        ));
  }
}
