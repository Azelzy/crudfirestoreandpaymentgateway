import 'package:crudfirestoreandpaymentgateway/controller/mainnav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainnavPage extends StatelessWidget {
  MainnavPage({super.key});

  final controller = Get.find<MainnavController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Obx(
      () => Scaffold(
        body: Column(
          children: [
            if (isTablet)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFFEB8D9F),
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 3),
                  ),
                ),
                child: const Text(
                  'BURGER QUEEN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
              ),
            Expanded(
              child: controller.pages[controller.selectedIndex.value],
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.black, width: 3),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFFBDDAF0),
            elevation: 0,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black54,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: isTablet ? 13 : 12,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: isTablet ? 13 : 12,
            ),
            iconSize: isTablet ? 26 : 28,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(isTablet ? 6 : 8),
                  decoration: BoxDecoration(
                    color: controller.selectedIndex.value == 0
                        ? const Color(0xFF9B97D1)
                        : Colors.transparent,
                    border: Border.all(
                      color: controller.selectedIndex.value == 0
                          ? Colors.black
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: const Icon(Icons.home_rounded),
                ),
                label: "HOME",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(isTablet ? 6 : 8),
                  decoration: BoxDecoration(
                    color: controller.selectedIndex.value == 1
                        ? const Color(0xFF9B97D1)
                        : Colors.transparent,
                    border: Border.all(
                      color: controller.selectedIndex.value == 1
                          ? Colors.black
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: const Icon(Icons.shopping_cart_rounded),
                ),
                label: "CART",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(isTablet ? 6 : 8),
                  decoration: BoxDecoration(
                    color: controller.selectedIndex.value == 2
                        ? const Color(0xFF9B97D1)
                        : Colors.transparent,
                    border: Border.all(
                      color: controller.selectedIndex.value == 2
                          ? Colors.black
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: const Icon(Icons.person_2_rounded),
                ),
                label: "PROFILE",
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changePage,
          ),
        ),
      ),
    );
  }
}