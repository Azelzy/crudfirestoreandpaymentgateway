import 'package:crudfirestoreandpaymentgateway/controller/cart_controller.dart';
import 'package:crudfirestoreandpaymentgateway/controller/mainnav_controller.dart';
import 'package:crudfirestoreandpaymentgateway/controller/payment_controller.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainnavController>(() => MainnavController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<PaymentController>(() => PaymentController());
  }
}
