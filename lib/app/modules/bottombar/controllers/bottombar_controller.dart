import 'package:axlpl_delivery/app/data/models/login_model.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/pageview_view.dart';
import 'package:axlpl_delivery/app/modules/history/views/history_view.dart';
import 'package:axlpl_delivery/app/modules/home/views/home_view.dart';
import 'package:axlpl_delivery/app/modules/shipnow/views/shipnow_view.dart';
import 'package:axlpl_delivery/app/modules/tracking/views/tracking_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/localstorage/local_storage.dart';

class BottombarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  var userData = Rxn<LoginModel>();
  final isLoading = true.obs;
  List<Widget> bottomList = <Widget>[
    HomeView(),
    TrackingView(),
    // PageviewView(),
    ShipnowView(),
    HistoryView()
  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  Future<void> loadUserData() async {
    isLoading.value = true;
    try {
      userData.value = await LocalStorage().getUserLocalData();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    loadUserData();
    super.onInit();
  }
}
