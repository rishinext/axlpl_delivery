import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/bottombar/bindings/bottombar_binding.dart';
import '../modules/bottombar/views/bottombar_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
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
  ];
}
