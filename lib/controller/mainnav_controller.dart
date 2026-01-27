import 'package:crudfirestoreandpaymentgateway/page/cart_page.dart';
import 'package:crudfirestoreandpaymentgateway/page/home_page.dart';
import 'package:crudfirestoreandpaymentgateway/page/profile_page.dart';
import 'package:get/get.dart';

class MainnavController extends GetxController {
  var selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }

  final pages = [HomePage(), CartPage(), ProfilePage()];
}
