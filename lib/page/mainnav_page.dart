import 'package:crudfirestoreandpaymentgateway/controller/mainnav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainnavPage extends StatelessWidget {
  MainnavPage({super.key});

  final controller = Get.find<MainnavController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Column(
          children: [
            Padding(padding: const EdgeInsets.fromLTRB(12, 12, 12, 6)),
            Expanded(child: controller.pages[controller.selectedIndex.value]),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded),
              label: "Profile",
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changePage,
        ),
      ),
    );
  }
}
