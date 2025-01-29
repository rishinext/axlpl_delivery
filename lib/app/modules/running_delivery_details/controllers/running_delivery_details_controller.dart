import 'package:get/get.dart';

class RunningDeliveryDetailsController extends GetxController {
  //TODO: Implement RunningDeliveryDetailsController

  RxInt activeStep = 0.obs;

  final List<String> stepTitles = [
    "In Transit",
    "Out for Delivery",
    "Delivery Attempted",
  ];

  final List<String> stepSubtitles = [
    "En Route",
    "Local Delivery Network",
    "Recipients Address",
  ];

  final List<String> stepDates = [
    "January, 31, 2024",
    "January, 31, 2024",
    "Today, 12:30",
  ];
}
