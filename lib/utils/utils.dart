import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:axlpl_delivery/app/data/models/lat_long_model.dart';
import 'package:axlpl_delivery/utils/theme.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

Themes themes = Themes();
final player = AudioPlayer();

class Utils {
  Utils._privateConstructor();
  static final Utils instance = Utils._privateConstructor();

  Utils._internal();
  static final Utils _instance = Utils._internal();

  factory Utils() {
    return _instance;
  }

  var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 6, // Number of method calls to be displayed
      errorMethodCount: 10, // Number of method calls if stacktrace is provided
      lineLength: 500, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      // Should each log print contain a timestamp
    ),
  );

  void logError(String message, [StackTrace? stackTrace]) {
    // Log the error message
    log("Error: $message");
    if (stackTrace != null) {
      log("StackTrace: $stackTrace");
    }
  }

  void logInfo(dynamic info) {
    logger.i(info);
  }

  void log(
    dynamic info,
  ) {
    logger.d(info);
  }

  String? validatePhone(String? value) {
    // Regex for phone number validation (example for US numbers)
    final RegExp phoneExp = RegExp(r'^\+?[1-9]\d{1,14}$');
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!phoneExp.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validateEmail(String? value) {
    // Regex for phone number validation (example for US numbers)
    final RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty) {
      return 'Email ID is required';
    } else if (!emailExp.hasMatch(value)) {
      return 'Enter a valid Email ID';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Value is required';
    }
    return null;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<UserLocation> getUserLocation() async {
    final position = await determinePosition();
    final latitude = position.latitude;
    final longitude = position.longitude;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks.first;

    final address =
        "${place.name}, ${place.street}, ${place.postalCode}, ${place.locality}, ${place.country}";

    return UserLocation(
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
  }

  Future<String?> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // OR androidInfo.androidId (better)
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    }

    return null;
  }

  Future<String?> scanAndPlaySound(BuildContext context) async {
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
      cameraFace: CameraFace.back,
    );

    if (res != null && res.isNotEmpty && res != '-1') {
      await player.play(AssetSource('beep.mp3'));
      logInfo('Scanned: $res');
      return res; // <<<< return valid result here
    } else {
      log('Scan cancelled or invalid');
      return null; // <<<< or return null if invalid
    }
  }
}
