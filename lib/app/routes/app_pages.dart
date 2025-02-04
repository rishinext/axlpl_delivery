import 'package:get/get.dart';

import '../modules/add_shipment/bindings/add_shipment_binding.dart';
import '../modules/add_shipment/views/add_shipment_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/bottombar/bindings/bottombar_binding.dart';
import '../modules/bottombar/views/bottombar_view.dart';
import '../modules/consignment/bindings/consignment_binding.dart';
import '../modules/consignment/views/consignment_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/pickup/bindings/pickup_binding.dart';
import '../modules/pickup/views/pickup_view.dart';
import '../modules/pod/bindings/pod_binding.dart';
import '../modules/pod/views/pod_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/running_delivery_details/bindings/running_delivery_details_binding.dart';
import '../modules/running_delivery_details/views/running_delivery_details_view.dart';
import '../modules/shipnow/bindings/shipnow_binding.dart';
import '../modules/shipnow/bindings/shipnow_binding.dart';
import '../modules/shipnow/views/shipnow_view.dart';
import '../modules/shipnow/views/shipnow_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tracking/bindings/tracking_binding.dart';
import '../modules/tracking/views/tracking_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.BOTTOMBAR;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOMBAR,
      page: () => const BottombarView(),
      binding: BottombarBinding(),
    ),
    GetPage(
      name: _Paths.TRACKING,
      page: () => const TrackingView(),
      binding: TrackingBinding(),
    ),
    GetPage(
      name: _Paths.SHIPNOW,
      page: () => const ShipnowView(),
      binding: ShipnowBinding(),
      children: [
        GetPage(
          name: _Paths.SHIPNOW,
          page: () => const ShipnowView(),
          binding: ShipnowBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.PICKUP,
      page: () => const PickupView(),
      binding: PickupBinding(),
    ),
    GetPage(
      name: _Paths.POD,
      page: () => const PodView(),
      binding: PodBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CONSIGNMENT,
      page: () => const ConsignmentView(),
      binding: ConsignmentBinding(),
    ),
    GetPage(
      name: _Paths.RUNNING_DELIVERY_DETAILS,
      page: () => const RunningDeliveryDetailsView(),
      binding: RunningDeliveryDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SHIPMENT,
      page: () => const AddShipmentView(),
      binding: AddShipmentBinding(),
    ),
  ];
}
