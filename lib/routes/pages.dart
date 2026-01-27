import 'package:crudfirestoreandpaymentgateway/binding/app_binding.dart';
import 'package:crudfirestoreandpaymentgateway/page/cart_page.dart';
import 'package:crudfirestoreandpaymentgateway/page/mainnav_page.dart';
import 'package:crudfirestoreandpaymentgateway/page/payment_page.dart';
import 'package:crudfirestoreandpaymentgateway/page/profile_page.dart';
import 'package:crudfirestoreandpaymentgateway/routes/routes.dart';
import 'package:get/get.dart';

import '../page/home_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.mainnavpage,
      page: () => MainnavPage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: AppRoutes.homePage,
      page: () => HomePage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: AppRoutes.cartpage,
      page: () => CartPage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: AppRoutes.paymentpage,
      page: () => PaymentPage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfilePage(),
      binding: AppBinding(),
    ),
  ];
}
