import 'dart:async';
import 'dart:developer';

import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NetworkConnectivity extends StatefulWidget {
  const NetworkConnectivity({super.key});

  @override
  State<NetworkConnectivity> createState() => _NetworkConnectivityState();
}

class _NetworkConnectivityState extends State<NetworkConnectivity> {
  Connectivity connectivity = Connectivity();
  IconData? icon;
  String connectionType = "No internet connection";
  bool isOffline = true;
  late StreamSubscription connectionSubscription;

  Future<void> getConnectivity() async {
    try {
      final result = await connectivity.checkConnectivity();
      getConnectionType(result.first);
      if (mounted) {
        updateConnectionStatus(result.first);
      }
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      icon = Icons.signal_wifi_connected_no_internet_4;
    }
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    getConnectionType(result);
    setState(() {
      isOffline = result == ConnectivityResult.none;
    });
  }

  @override
  void initState() {
    super.initState();
    getConnectivity();

    connectionSubscription = connectivity.onConnectivityChanged.listen(
      (result) {
        if (result.isEmpty) {
          updateConnectionStatus(ConnectivityResult.none);
        } else {
          updateConnectionStatus(result.first);
        }
      },
    );
  }

  @override
  void dispose() {
    connectionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: isOffline ? Colors.red : Colors.green),
          ],
        ),
      ),
    );
  }

  void getConnectionType(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile) {
      connectionType = "Internet connection is from Mobile data";
      icon = Icons.network_cell;
    } else if (result == ConnectivityResult.wifi) {
      connectionType = "Internet connection is from wifi";
      icon = Icons.network_wifi_sharp;
    } else if (result == ConnectivityResult.ethernet) {
      connectionType = "Internet connection is from wired cable";
      icon = Icons.settings_ethernet;
    } else if (result == ConnectivityResult.bluetooth) {
      connectionType = "Internet connection is from Bluetooth tethering";
      icon = Icons.network_wifi_sharp;
    } else if (result == ConnectivityResult.none) {
      connectionType = "No internet connection";
      icon = Icons.signal_wifi_connected_no_internet_4;
    }
  }
}
