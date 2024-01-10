import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yesmachinery/src/features/home/screens/dashboard.dart';
import 'package:yesmachinery/src/features/profile/screens/profile.dart';
import 'package:yesmachinery/src/features/productdetails/screens/enquiry.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 60,
          elevation: 5,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: Theme.of(context).backgroundColor,
          indicatorColor: Colors.lightGreen,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home, color: Colors.lightGreen),
              selectedIcon: Icon(Icons.home, color: Colors.white),
              label: "Home",
            ),
            NavigationDestination(
                icon: Icon(Icons.account_circle, color: Colors.lightGreen),
                selectedIcon: Icon(Icons.account_circle, color: Colors.white),
                label: "Profile"),
            NavigationDestination(
                icon: Icon(Icons.file_copy, color: Colors.lightGreen),
                selectedIcon: Icon(Icons.file_copy, color: Colors.white),
                label: "Enquiry"),
          ],
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [Dashboard(), Profile(), EnquiryScreen(key: UniqueKey(), product: "")];
}
