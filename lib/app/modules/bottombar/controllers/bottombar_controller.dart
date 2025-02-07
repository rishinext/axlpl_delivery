import 'package:axlpl_delivery/app/modules/add_shipment/views/add_shipment_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/pageview_view.dart';
import 'package:axlpl_delivery/app/modules/history/views/history_view.dart';
import 'package:axlpl_delivery/app/modules/home/views/home_view.dart';
import 'package:axlpl_delivery/app/modules/shipnow/views/shipnow_view.dart';
import 'package:axlpl_delivery/app/modules/tracking/views/tracking_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottombarController extends GetxController {
  RxInt selectedIndex = 0.obs;

  List<Widget> bottomList = <Widget>[
    HomeView(),
    TrackingView(),
    PageviewView(),
    HistoryView()
  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
