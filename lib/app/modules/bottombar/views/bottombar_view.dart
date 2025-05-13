import 'package:axlpl_delivery/app/data/models/login_model.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/bottombar_controller.dart';

class BottombarView extends GetView<BottombarController> {
  const BottombarView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottombarController());
    final LoginModel? usersData = Get.arguments;

    return Scaffold(
      body: Obx(() =>
          controller.bottomList.elementAt(controller.selectedIndex.value)),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: themes.fontSize18_600
              .copyWith(fontSize: 14.sp, color: themes.whiteColor),
          unselectedLabelStyle: themes.fontSize18_600
              .copyWith(fontSize: 14.sp, color: themes.grayColor),
          backgroundColor: themes.darkCyanBlue,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(homeIcon)),
              label: usersData?.messangerdetail?.name ?? 'User',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(trackingIcon)),
              label: 'Tracking',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(shipIcon)),
              label: 'Ship Now',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(historyIcon)),
              label: 'History',
            )
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: themes.whiteColor,
          unselectedItemColor: themes.grayColor,
          onTap: controller.onItemTapped,
        ),
      ),
    );
  }
}
