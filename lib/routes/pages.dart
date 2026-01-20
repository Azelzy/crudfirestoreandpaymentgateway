import 'package:crudfirestoreandpaymentgateway/routes/routes.dart';
import 'package:get/get.dart';

import '../binding/home_binding.dart';
import '../page/home_page.dart';

class AppPages {
  static final pages = [
    // Home Page
    GetPage(
      name: AppRoutes.homePage,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}