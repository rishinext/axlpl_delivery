import 'dart:convert';

import 'package:axlpl_delivery/app/data/models/login_model.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/auth_repo.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_shipment_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/pageview_view.dart';
import 'package:axlpl_delivery/app/modules/history/views/history_view.dart';
import 'package:axlpl_delivery/app/modules/home/views/home_view.dart';
import 'package:axlpl_delivery/app/modules/shipnow/views/shipnow_view.dart';
import 'package:axlpl_delivery/app/modules/tracking/views/tracking_view.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

import '../../../data/localstorage/local_storage.dart';

class BottombarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  var userData = Rx<LoginModel?>(null);

  List<Widget> bottomList = <Widget>[
    HomeView(),
    TrackingView(),
    PageviewView(),
    HistoryView()
  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  Future<void> loadUserLocalData() async {
    userData.value = await LocalStorage().getUserLocalData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    loadUserLocalData();
    super.onInit();
  }
}
